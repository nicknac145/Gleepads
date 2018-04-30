//
//  ForgetVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 19/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import SwiftVideoBackground
import FirebaseAuth

class ForgetVC: UIViewController {
    @IBOutlet weak var emailTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    // **************  BACKGROUND VIDEO PLAYER ***************
        try? VideoBackground.shared.play(view: view, videoName: "forget", videoType: "mp4")

    }

    @IBAction func nextButton(_ sender: Any) {
    
        
        // ************** Reset Password  ***************

        
        Auth.auth().sendPasswordReset(withEmail: emailTF.text!) { (error) in
            if error == nil{
                
                let alert = UIAlertController(title: "Alert", message: "Step to Reset Password has been sent to your email address ", preferredStyle: .alert)
                let actionButton = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainVC
                    
                    let navController = UINavigationController(rootViewController: mainVC)
                    self.present(navController, animated: true, completion: nil)
                })
                alert.addAction(actionButton)
               
                self.present(alert, animated: true, completion: nil)
                
               
                
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
