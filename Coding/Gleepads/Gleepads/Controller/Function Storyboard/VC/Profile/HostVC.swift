//
//  HostVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 24/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
//import Shift

class HostVC: UIViewController {

    @IBOutlet weak var step1_view: UIView!
    @IBOutlet weak var step2_view: UIView!
    @IBOutlet weak var step3_view: UIView!
    @IBOutlet weak var step1_button: Custom_Button!
    @IBOutlet weak var step2_Button: Custom_Button!
    @IBOutlet weak var step3_Button: Custom_Button!
    
    var hostingData = ["User_ID":"",
                       "AD-Title":"",
                       "Property-Category":"",
                       "City":"",
                       "Lat-Long":"",
                       "Mininum-day":"",
                       "Check-in":"",
                       "Check-out":"","Rent":"",
                       "Description":""
                       ]
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    
    step2_view.alpha = 0.3
    step2_Button.isEnabled = false
    
    step3_view.alpha = 0.3
    step3_Button.isEnabled = false
    }

    @IBAction func step1_Button_Action(_ sender: Any) {
        step2_view.alpha = 1
        step2_Button.isEnabled = true
        
        step3_view.alpha = 0.3
        step3_Button.isEnabled = false
    }
    
    
    @IBAction func step2_Button_Action(_ sender: Any) {
        step3_view.alpha = 1
        step3_Button.isEnabled = true
        
      
    }
    

    @IBAction func step3_Button_Action(_ sender: Any) {
        let alert = UIAlertController(title: "SUCCESS!", message: "YOU PROPERTY DETAIL HAS BEEN STORED", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
      
    }
    @IBAction func dismissButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
 
    
}
