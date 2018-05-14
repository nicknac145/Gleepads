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
                       "Check-out":"",
                       "Available":"Yes",
                       "CheckIn-Date":"",
                       "CheckOut-Date":"",
                       "Guest-Name":""
        
                       ]
    
    var hostImages = [UIImage]()
    var count = 1
    var urlString : String?
    var urlArray = [String]()

    var ref =  Database.database().reference()
    
    let storage = Storage.storage()
    
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
        
        
        
        // *********** Uploading Photo ***************
        
        for image in self.hostImages{
            
            var imageData = Data()
            imageData = UIImagePNGRepresentation(image)!
            
            
            
            let storageRef = self.storage.reference().child((Auth.auth().currentUser?.uid)!).child("Hosting").child(self.hostingData["AD-Title"]!).child("property\(self.count)")
            
            self.count += 1
            let uploadMetaData = StorageMetadata()
            uploadMetaData.contentType = "image/jpeg"
            storageRef.putData(imageData, metadata: uploadMetaData, completion: { (metaData, error) in
                
                if error != nil{
                    
                    let alert = UIAlertController(title: "ERROR!", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                    
                    self.present(alert, animated: true, completion: nil)
                    
                    self.urlArray.append((metaData?.downloadURL()?.description)!)
                     print("METADATA:\(metaData?.downloadURL()?.description)!")
                    
                }
                    
                    
                else{

                    self.urlArray.append((metaData?.downloadURL()?.description)!)
                    
                    
                    print("-------------------")
                    print("METADATA:\(metaData?.downloadURL()?.description)!")
                    print("ARRAY:\(self.urlArray)")
                    print("-------------------")


                    
                }
            })
   
        }
        
        
        
    
        
       
        print("FINAL RESULT: \(self.urlArray)")
        
//****************************************
        let alert = UIAlertController(title: "SUCCESS!", message: "YOU PROPERTY DETAIL HAS BEEN STORED", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { (alert) in
            self.navigationController?.popViewController(animated: true)

        }
//************************************
        alert.addAction(action)
       
        
        self.present(alert, animated: true) {
           
            
//            for image in self.hostImages{
//
//                var imageData = Data()
//                imageData = UIImagePNGRepresentation(image)!
//
//
//
//                let storageRef = self.storage.reference().child((Auth.auth().currentUser?.uid)!).child("Hosting").child(self.hostingData["AD-Title"]!).child("property\(self.count)")
//
////                self.count += 1
//                let uploadMetaData = StorageMetadata()
//                uploadMetaData.contentType = "image/jpeg"
//                storageRef.putData(imageData, metadata: uploadMetaData, completion: { (metaData, error) in
//
//                    if error != nil{
//
//                        print("i recieved error \(error?.localizedDescription)")
//                    }
//                    else{
//
//
//
//                        self.urlArray.append((metaData?.downloadURL()?.description)!)
//                        print("METADATA:\(metaData?.downloadURL()?.description)!")
//
//                        self.count += 1
//                    }
//                })
//
//
//
//            }
            
            
            if self.count == self.hostImages.count{
                
                                        print("ARRAY:\(self.urlArray)")
            }
            //
//            self.ref.child("Hosting").child((Auth.auth().currentUser?.uid)!).childByAutoId().setValue(self.hostingData)
            
        
        }
    }
}
