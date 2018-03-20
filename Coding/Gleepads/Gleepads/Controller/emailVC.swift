//
//  emailVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 16/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class emailVC: UIViewController {

    @IBOutlet weak var nextButton: Custom_Button!
    @IBOutlet weak var emailTF: UITextField!
    
    
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
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func enableButton(_ textField : UITextField){
        
        if (emailTF.isEditing == true && emailTF.text?.isEmpty == false){
            nextButton.isEnabled = true
            nextButton.alpha = 1.0
        }
       
        
    }
}
