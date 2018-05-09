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


                // ********************    " PROTOCOLS " ***************************


// ********* Created Delegate to fetch Data from Step1 VC ***************
protocol step1Delegate {
    func DataColletion(propertyTitle : String, propertyCatergory: String, propertyAmenities : String, propertyMininum : String, propertyDescription:String)
}


// ********* Created Delegate to fetch Data from Step2 VC ***************

protocol step2Delegate {
    func DataColletion(latitude : String, Longitude : String, PropertyImage : [UIImage], CityName: String, CountryName : String)
}


protocol step3Delegate {
    func DataColletion(Rent : String, PaymentMode : String, Guest : String, Check_In : String, Check_Out:String)
}







class HostVC: UIViewController, step1Delegate, step2Delegate, step3Delegate {
 
    

  // ********* DELEGATE INITIALIZE *************
    
    func DataColletion(propertyTitle: String, propertyCatergory: String, propertyAmenities: String, propertyMininum: String, propertyDescription: String) {
        hostingData["User_ID"] = Auth.auth().currentUser?.uid
        hostingData["AD-Title"] = propertyTitle
        hostingData["Property-Category"] = propertyCatergory
        hostingData["Amenities"] = propertyAmenities
        hostingData["Mininum-Day"] = propertyMininum
        hostingData["Description"] = propertyDescription
        
        
    }
    
    func DataColletion(latitude: String, Longitude: String, PropertyImage: [UIImage], CityName: String, CountryName: String) {
        hostImages = PropertyImage
        hostingData["Latitude"] = latitude
        hostingData["Longitude"] = Longitude
        hostingData["City"] = CityName
        hostingData["Country"] = CountryName
    }
    
    
    func DataColletion(Rent : String, PaymentMode : String, Guest : String, Check_In : String, Check_Out:String){
        
        hostingData["Rent"] = Rent
        hostingData["Payment-Mode"] = PaymentMode
        hostingData["Guest-Number"] = Guest
        hostingData["Check-in"] = Check_In
        hostingData["Check-out"] = Check_Out
      
    }
    

    // ************* OUTLET *******************
    
    @IBOutlet weak var step1_view: UIView!
    @IBOutlet weak var step2_view: UIView!
    @IBOutlet weak var step3_view: UIView!
    @IBOutlet weak var step1_button: Custom_Button!
    @IBOutlet weak var step2_Button: Custom_Button!
    @IBOutlet weak var step3_Button: Custom_Button!
    @IBOutlet weak var Confirm_Button: Custom_Button!
    
    
    
    // *******  DICTIONARY OF USER'S PROPERTY RENT ADVERTISE PROFILE ***************
    var hostingData = ["User_ID":"",
                       "AD-Title":"",
                       "Property-Category":"",
                       "Amenities": "",
                       "Mininum-Day":"",
                       "Description":"",
                       "City":"",
                       "Country":"",
                       "Latitude":"",
                       "Longitude":"",
                        "Rent":"",
                        "Payment-Mode":"",
                        "Guest-Number":"",
                       "Check-in":"",
                       "Check-out":""
        
                       ]
    
    var hostImages = [UIImage]()
    

    var ref =  Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // *********** CONFIGURE NAVIGATOIN BAR SETTING  ***************

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    
        
        // ********* SETTING INITIAL BUTTON VISUAL LOOK ************
    step2_view.alpha = 0.3
    step2_Button.isEnabled = false
    
    step3_view.alpha = 0.3
    step3_Button.isEnabled = false
        
    Confirm_Button.isHidden = true
        
    
    }

    
    // *******  STEP 1 BUTTON ACTION **************
    
    @IBAction func step1_Button_Action(_ sender: Any) {
        step2_view.alpha = 1
        step2_Button.isEnabled = true
        
        step3_view.alpha = 0.3
        step3_Button.isEnabled = false
        
        performSegue(withIdentifier: "Step1_Segue", sender: self)
    }
    
    // *******  STEP 2 BUTTON ACTION **************

    
    @IBAction func step2_Button_Action(_ sender: Any) {
        step3_view.alpha = 1
        step3_Button.isEnabled = true
        
performSegue(withIdentifier: "Step2_Segue", sender: self)
    }
    
    // *******  STEP 3 BUTTON ACTION **************

    
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
            
            dest.hostDelegate = self


        }
        else if segue.identifier == "Step3_Segue" {
            let dest = segue.destination as! Step3VC

          
            dest.hostDelegate = self
            Confirm_Button.isHidden = false

        }
    }
    
    @IBAction func Confirm_Button_Action(_ sender: Any) {
        
        
        print(hostingData)
        print(hostImages)
        
        let alert = UIAlertController(title: "SUCCESS!", message: "YOU PROPERTY DETAIL HAS BEEN STORED", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (Alert) in
            
            print(Auth.auth().currentUser?.uid)
            
            
//            self.ref.child("Hosting").child((Auth.auth().currentUser?.uid)!).childByAutoId().child("User ID").setValue((Auth.auth().currentUser?.uid)!)
            self.ref.child("Hosting").child((Auth.auth().currentUser?.uid)!).childByAutoId().setValue(self.hostingData)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
