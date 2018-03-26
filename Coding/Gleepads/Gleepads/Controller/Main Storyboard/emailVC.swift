//
//  emailVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 16/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import SwiftVideoBackground

class emailVC: UIViewController {

    @IBOutlet weak var nextButton: Custom_Button!
    @IBOutlet weak var emailTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        try? VideoBackground.shared.play(view: view, videoName: "myVideo", videoType: "mp4")

        
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
        
        try? VideoBackground.shared.play(view: view, videoName: "intro", videoType: "mp4")
        
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
