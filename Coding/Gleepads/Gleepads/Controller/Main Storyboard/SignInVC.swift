//
//  SignInVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 19/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import SwiftVideoBackground
import Firebase
import FirebaseAuth

class SignInVC: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // ***********  BACKGROUND VIDEO PLAYER ***************

        try? VideoBackground.shared.play(view: view, videoName: "login", videoType: "mp4")
        
    }
    
    
    // *********** FUNCTION THAT ENABLE SECURE TEXT  ***************

    @IBAction func showPassword(_ sender: Any) {
        
        if   passwordTF.isSecureTextEntry == true{
            passwordTF.isSecureTextEntry = false
        }
        else{
            passwordTF.isSecureTextEntry = true
        }
        
    }
    

    @IBAction func nextButton(_ sender: Any) {
        
        
        // ******** Sign IN if Auth is TRUE *************
        Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!) { (user, error) in
           
            if error == nil{
                  self.present( UIStoryboard(name: "Function", bundle: nil).instantiateViewController(withIdentifier: "Function_First_View") as UIViewController, animated: true, completion: nil)
            }
            else{
                let alert = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: .alert)
                let actionButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(actionButton)
                self.present(alert, animated: true, completion: nil)
                
            }
        }
        
  
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    
}
