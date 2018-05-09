//
//  NewAccountVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 16/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import SwiftVideoBackground

class NewAccountVC: UIViewController {

    @IBOutlet weak var NextButton: Custom_Button!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pickerView: UIView!
    @IBOutlet weak var dobLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // *********** CONFIGURE NAVIGATOIN BAR SETTING  ***************

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        pickerView.isHidden = true
        datePicker.datePickerMode = .date
        
        let tapped = UITapGestureRecognizer(target: self, action: #selector(enablePicker))
        dobLabel.addGestureRecognizer(tapped)
        // ********* Disabling Button **************
            NextButton.isEnabled = false
            NextButton.alpha = 0.5
       
     // ******  Define Action target when to enable "nextButton" *************
        firstNameTF.addTarget(self, action: #selector(enableButton), for: .editingChanged)
        lastNameTF.addTarget(self, action: #selector(enableButton), for: .editingChanged)
        
       
     
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    
        
        // *********** BACKGROUND VIDEO PLAYER  ***************

        try? VideoBackground.shared.play(view: view, videoName: " signup", videoType: "mp4")
        
    }

    @objc func enablePicker(recog: UIGestureRecognizer){


        pickerView.isHidden = false
        view.endEditing(true)
//        dobPickerAction()
    }
    
    // ******* Function which will take decision when to enable "nextButton" **********
    @objc func enableButton(_ textField : UITextField){
        
        if (firstNameTF.isEditing == true && lastNameTF.text?.isEmpty == false){
            NextButton.isEnabled = true
            NextButton.alpha = 1.0
        }
        else if (lastNameTF.isEditing == true && firstNameTF.text?.isEmpty == false){
            NextButton.isEnabled = true
            NextButton.alpha = 1.0
            
        }
        
    }
    
    
    
    // *********** Extract Selected Date ************
@IBAction func dobPickerAction() {
        let format = DateFormatter()
        format.dateFormat = "dd-MM-YYYY"
        let date = format.string(from: datePicker.date)
        self.dobLabel.text = date
        self.dobLabel.textColor = UIColor.black
    }
    
    
    
    // ******* Action Function "nextButton" **********

    @IBAction func nextButtonAction(_ sender: Any) {
        
        performSegue(withIdentifier: "Email_Segue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let email_dest = segue.destination as! emailVC
        email_dest.fName = firstNameTF.text!
        email_dest.lName = lastNameTF.text!
        email_dest.dob = dobLabel.text!
    }
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
