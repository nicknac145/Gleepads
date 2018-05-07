//
//  HostVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 24/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
//import Shift
import Firebase


protocol step1Delegate {
    func DataColletion(propertyTitle : String, propertyCatergory: String, propertyAmenities : String, propertyMininum : String, propertyDescription:String)
}


class HostVC: UIViewController, step1Delegate {
   
    
    func DataColletion(propertyTitle: String, propertyCatergory: String, propertyAmenities: String, propertyMininum: String, propertyDescription: String) {
        hostingData["User_ID"] = Auth.auth().currentUser?.uid
        hostingData["AD-Title"] = propertyTitle
        hostingData["Property-Catergory"] = propertyCatergory
        hostingData["Amenities"] = propertyAmenities
        hostingData["Mininum-Day"] = propertyMininum
        hostingData["Description"] = propertyDescription
        
        
        print(hostingData)
    }
    

    @IBOutlet weak var step1_view: UIView!
    @IBOutlet weak var step2_view: UIView!
    @IBOutlet weak var step3_view: UIView!
    @IBOutlet weak var step1_button: Custom_Button!
    @IBOutlet weak var step2_Button: Custom_Button!
    @IBOutlet weak var step3_Button: Custom_Button!
    
    var hostingData = ["User_ID":"",
                       "AD-Title":"",
                       "Property-Category":"",
                       "Amenities": "",
                       "Mininum-Day":"",
                       "Description":"",
                       "City":"",
                       "Country":"",
                       "Lat-Long":"",
                        "Rent":"",
                        "Mode-Of-Payment":"",
                        "Guest-Number":"",
                       "Check-in":"",
                       "Check-out":""
                       

                       ]
    
    var hostImages = [UIImage]()
    

    
    
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
        
        performSegue(withIdentifier: "Step1_Segue", sender: self)
    }
    
    
    @IBAction func step2_Button_Action(_ sender: Any) {
        step3_view.alpha = 1
        step3_Button.isEnabled = true
        
performSegue(withIdentifier: "Step2_Segue", sender: self)
    }
    

    @IBAction func step3_Button_Action(_ sender: Any) {
        
        performSegue(withIdentifier: "Step3_Segue", sender: self)

    }
    @IBAction func dismissButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Step1_Segue"{
            
            let dest = segue.destination as! Step1VC
            
            
          dest.hostDelegate = self
            
            
            
        }
        else if segue.identifier == "Step2_Segue"{
            let dest = segue.destination as! Step2VC


        }
        else if segue.identifier == "Step3_Segue" {
            let dest = segue.destination as! Step3VC

        }
    }
    
}
