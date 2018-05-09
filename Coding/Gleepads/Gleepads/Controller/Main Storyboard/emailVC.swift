//
//  emailVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 16/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import SwiftVideoBackground
import FirebaseAuth
import FirebaseDatabase

class emailVC: UIViewController {

    @IBOutlet weak var nextButton: Custom_Button!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    
    // ******* Variable that will hold basic Info about user ************
    var fName : String?
    var lName : String?
    var dob : String?
    
    // ******* Firebase Database reference
    var dbRef = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // ************ remove Navigator bar Border *************
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // ********* Disabling Button **************
        nextButton.isEnabled = false
        nextButton.alpha = 0.5
        
        emailTF.addTarget(self, action: #selector(enableButton), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        // *********** BACKGORUND VIDEO PLAYER  ***************

        try? VideoBackground.shared.play(view: view, videoName: "e-mail", videoType: "mp4")
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    
    }
    
    
    // Action on pressing next button
    @IBAction func nextButtonAction(_ sender: Any) {
      
        let newEmail = emailTF.text
        let password = passTF.text
        Auth.auth().createUser(withEmail: newEmail!, password: password!) { (user, error) in

            if error == nil{
               
                // *** update database node "USER-PROFILE" ***
                self.dbRef.child("User_Profile").child((Auth.auth().currentUser?.uid)!).child("User_Fname").setValue(self.fName!)
                self.dbRef.child("User_Profile").child((Auth.auth().currentUser?.uid)!).child("User_Lname").setValue(self.lName!)
                self.dbRef.child("User_Profile").child((Auth.auth().currentUser?.uid)!).child("User_Email").setValue(Auth.auth().currentUser?.email)
                
                self.dbRef.child("User_Profile").child((Auth.auth().currentUser?.uid)!).child("User_Uid").setValue(Auth.auth().currentUser?.uid)
                
                self.dbRef.child("User_Profile").child((Auth.auth().currentUser?.uid)!).child("User_DOB").setValue(self.dob!)
                
                // *** SEGUE RETURN STARTUP SCENE ***

                self.present( UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Main_Nav") as UIViewController, animated: true, completion: nil)
                
                
            }
            else{
                let alert = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: .alert)
                let actionButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(actionButton)
                self.present(alert, animated: true, completion: nil)
                
            }
        }
    }
    
    
    
    
    
    // FUNCTION THAT CHECK WHEN TO ENABLE BUTTON
    @objc func enableButton(_ textField : UITextField){
        
        if (emailTF.isEditing == true && emailTF.text?.isEmpty == false){
            nextButton.isEnabled = true
            nextButton.alpha = 1.0
        }
//        else if (passTF.isEditing == true && emailTF.text?.isEmpty == false){
//            nextButton.isEnabled = true
//            nextButton.alpha = 1.0
//
//        }
        
       
        
    }
}
