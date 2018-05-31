//
//  MainVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 14/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import SafariServices
import SwiftVideoBackground
import GoogleSignIn
import FirebaseAuth
import Firebase

import FBSDKLoginKit
import FacebookLogin
import FacebookCore

class MainVC: UIViewController,GIDSignInUIDelegate,GIDSignInDelegate {
   
    

 // ***********  variable ***************
    @IBOutlet weak var bottomLabel: UILabel!
    
    @IBOutlet weak var Phrase_Label: UILabel!
    
    
    
    var dbRef : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
Phrase_Label.font = UIFont(name: "BebasNeue-Regular", size: 15.0)
        
bottomLabel.font = UIFont(name: "BebasNeue-Regular", size: 14.0)
        
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        
        if Auth.auth().currentUser != nil {
             self.present( UIStoryboard(name: "Function", bundle: nil).instantiateViewController(withIdentifier: "Function_First_View") as UIViewController, animated: true, completion: nil)
        }
        
 // ***********  Configuration Navigation bar setting ***************
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
 // *********** Initialize Tapped function and add to bottomLabel  ***************
        let labelTapped = UITapGestureRecognizer(target: self, action: #selector(labelTouch))
        bottomLabel.addGestureRecognizer(labelTapped)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        // *********** BACKGROUND VIDEO PLAYER   ***************

        try? VideoBackground.shared.play(view: view, videoName: "intro", videoType: "mp4")
        
    }
    
    
    // *********** LOGIN BUTTON ACTION FUNCTION  ***************

    @IBAction func login_action(_ sender: Any) {
        performSegue(withIdentifier: "LoginSegue", sender: self)
    }
    
    
    // ***********   FUNCTION THAT DEFINE ACTION ON TAPPING ***************

    @objc func labelTouch(reccog: UIGestureRecognizer){

        let url = URL(string: "https://www.google.com")
    
        let svc = SFSafariViewController(url: url!)
        self.present(svc, animated: true, completion: nil)
    
    }
    
    
     // *********** Google BUTTON ACTION FUNCTION  ***************
    @IBAction func GoogleButton(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
        
        
    }
   
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        
        if  error == nil {
            // ...
            guard let authentication = user.authentication else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                           accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { (user, error) in
                if let error = error {
                    // ...
                    print(error.localizedDescription)
                }
                print("Google Sign IN Successfully")
                 self.present( UIStoryboard(name: "Function", bundle: nil).instantiateViewController(withIdentifier: "Function_First_View") as UIViewController, animated: true, completion: nil)
                
                
                print(user?.displayName)
                print(user?.email)
                print(user?.uid)
                
                var fullName = user?.displayName?.components(separatedBy: " ")
                let fName = fullName![0]
                let lName = fullName![1]
                
                print(fName)
                print(lName)
                
                self.dbRef = Database.database().reference()
                
                self.dbRef.child("User_Profile").child((Auth.auth().currentUser?.uid)!).child("User_Fname").setValue(fName)
                self.dbRef.child("User_Profile").child((Auth.auth().currentUser?.uid)!).child("User_Lname").setValue(lName)
                self.dbRef.child("User_Profile").child((Auth.auth().currentUser?.uid)!).child("User_Email").setValue(Auth.auth().currentUser?.email)

                self.dbRef.child("User_Profile").child((Auth.auth().currentUser?.uid)!).child("User_Uid").setValue(Auth.auth().currentUser?.uid)
                
                self.dbRef.child("User_Profile").child((Auth.auth().currentUser?.uid)!).child("User_DOB").setValue("")
                
                self.dbRef.child("User_Profile").child((Auth.auth().currentUser?.uid)!).child("ProfileImage_Url").setValue("")

                
            }
            
        }
        
        else{
            let alert = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: .alert)
            let actionButton = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(actionButton)
            self.present(alert, animated: true, completion: nil)
            
        }
      
    }
    
    
    
    
     // *********** Facebook BUTTON ACTION FUNCTION  ***************
    @IBAction func facebookButton(_ sender: Any) {
        

        FBSDKLoginManager().logIn(withReadPermissions: ["email","public_profile"], from: self) { (result, error) in

            
            
            if error == nil && result?.token != nil{

                guard let accessToken = result?.token.tokenString else{
                    return
                }

                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)

                Auth.auth().signIn(with: credential) { (user, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    print("SUCCESSFUL LOGIN WITH FACEBOOK")
                    
                    
                    
                    self.present( UIStoryboard(name: "Function", bundle: nil).instantiateViewController(withIdentifier: "Function_First_View") as UIViewController, animated: true, completion: nil)
//                    print(user?.displayName)
//                    print(user?.email)
                    
                    
                    var fullName = user?.displayName?.components(separatedBy: " ")
                    let fName = fullName![0]
                    let lName = fullName![1]
                    
                    print(fName)
                    print(lName)
                    
                    self.dbRef = Database.database().reference()
                    
                    self.dbRef.child("User_Profile").child((Auth.auth().currentUser?.uid)!).child("User_Fname").setValue(fName)
                    self.dbRef.child("User_Profile").child((Auth.auth().currentUser?.uid)!).child("User_Lname").setValue(lName)
                    self.dbRef.child("User_Profile").child((Auth.auth().currentUser?.uid)!).child("User_Email").setValue(Auth.auth().currentUser?.email)
                    
                    self.dbRef.child("User_Profile").child((Auth.auth().currentUser?.uid)!).child("User_Uid").setValue(Auth.auth().currentUser?.uid)
                    
                    self.dbRef.child("User_Profile").child((Auth.auth().currentUser?.uid)!).child("User_DOB").setValue("")
                    
                    self.dbRef.child("User_Profile").child((Auth.auth().currentUser?.uid)!).child("ProfileImage_Url").setValue("")

                }

            }
            
            else{
                print(error?.localizedDescription)
            }
//            else{
//                let alert = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: .alert)
//                let actionButton = UIAlertAction(title: "OK", style: .default, handler: nil)
//                alert.addAction(actionButton)
//                self.present(alert, animated: true, completion: nil)
//
//            }

        }
        
    }
    
}

