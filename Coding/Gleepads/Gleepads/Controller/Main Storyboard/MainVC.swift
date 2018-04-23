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

class MainVC: UIViewController,GIDSignInUIDelegate {
   
    

 // ***********  variable ***************
    @IBOutlet weak var bottomLabel: UILabel!
    
    @IBOutlet weak var Phrase_Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
Phrase_Label.font = UIFont(name: "BebasNeue-Regular", size: 15.0)
        
bottomLabel.font = UIFont(name: "BebasNeue-Regular", size: 14.0)
        
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
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
   
     // *********** Facebook BUTTON ACTION FUNCTION  ***************
    @IBAction func facebookButton(_ sender: Any) {
        

        FBSDKLoginManager().logIn(withReadPermissions: ["email","public_profile"], from: self) { (result, error) in

            if error == nil && result?.token != nil{

                guard let accessToken = result?.token.tokenString else{
                    return
                }


                print(accessToken)
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)

                Auth.auth().signIn(with: credential) { (user, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    print("SUCCESSFUL LOGIN WITH FACEBOOK")
//                    self.performSegue(withIdentifier: "Function_Segue", sender: nil)

                }

            }
            else{
                print(error?.localizedDescription)
            }

        }
        
    }
    
}

