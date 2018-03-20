//
//  SignInVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 19/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    @IBAction func showPassword(_ sender: Any) {
        
        if   passwordTF.isSecureTextEntry == true{
            passwordTF.isSecureTextEntry = false
        }
        else{
            passwordTF.isSecureTextEntry = true
        }
        
    }
    

    @IBAction func nextButton(_ sender: Any) {
        
    
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    
}
