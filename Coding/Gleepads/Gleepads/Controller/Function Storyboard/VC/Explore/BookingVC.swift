//
//  BookingVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 11/04/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

protocol dateFetching {
    func dateValue(Date : String)
}

protocol guestFetching {
    func guestValue(Adult : String, Children : String, Infant : String, Pet : String)
}





class BookingVC: UIViewController, dateFetching, guestFetching {
   
    
    
    func guestValue(Adult: String, Children: String, Infant : String, Pet: String) {
        
        self.AdultQuantity = Adult
        self.ChildrenQuantity = Children
        self.InfantQunatity = Infant
        self.PetStatus = Pet
       
    
        guestDisplay.text = "\(Adult) Adult, \(Children) Children, \(Infant) Infant (\(Pet) Pet)"
    }

    func dateValue(Date: String) {
        
        print("Date:\(Date)")
        
        self.dateValue = Date
        self.DateDisplay.text = Date
    }
    

    @IBOutlet weak var AD_Label: UILabel!
    @IBOutlet weak var Host_label: UILabel!
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var messageText: UITextView!
    @IBOutlet weak var Stay_Timeframe: UITextField!
    
    @IBOutlet weak var DateDisplay: UILabel!
    @IBOutlet weak var guestDisplay: UILabel!
    
    var Ad_Title : String?
    var dateValue : String?
    var AdultQuantity : String?
    var ChildrenQuantity : String?
    var InfantQunatity : String?
    var PetStatus : String?
    var rentAmount : String?
    var userID : String?
    
    
    var bookingData = ["AD_Title": "",
                       "User_Id":"",
                       "Period":"",
                       "Adult":"",
                       "Children":"",
                       "Infant":"",
                       "Pet":"",
                       "Message":"",
                       "Total Amount":""]
    
    var dbHandle : DatabaseHandle!
    var dbRef : DatabaseReference!
    
    var propertyDetail : DiscoveryData?

   
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AD_Label.text = Ad_Title!
      
        dbRef = Database.database().reference()
        
        dbHandle = dbRef.child("Hosting").observe(.childAdded, with: { (bookingSnapShoot) in
            
            let bookingValue = bookingSnapShoot.value as! [String : String]
            
            if bookingValue["AD_Title"] == self.Ad_Title!{
                let jsonData = try? JSONSerialization.data(withJSONObject: bookingSnapShoot.value as Any)
                self.propertyDetail = try? JSONDecoder().decode(DiscoveryData.self, from: jsonData!)
                
               //*******************************
               
                self.rentAmount = self.propertyDetail?.Rent
                self.userID = self.propertyDetail?.User_ID
                // *********** PROFILE *********************
                let userID = (self.propertyDetail?.User_ID)!
                //                print(userID)
                
                self.dbRef.child("User_Profile").child(userID).observe(.value, with: { (profile) in
                    
                    

                    let value = profile.value as! [String : String]
                    
                    print(value)
                    
                    let name = (value["User_Fname"])! + " " + (value["User_Lname"])!
                    self.Host_label.text = name

                    let imageString = (value["ProfileImage_Url"])!
                    let imageURL = URL(string: imageString)

                 
                    
                    self.ProfileImage.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "thumbnail"), options: .progressiveDownload, completed: nil)
                })
            }
            
            
        })
        
        
    }

 
    @IBAction func booking_button_action(_ sender: Any) {
        
       
        
        if (Stay_Timeframe.text != "") && (guestDisplay.text != "------") && (DateDisplay.text != "DD-MM-YYYY") && (messageText.text != "") {
            
            let rent = Int((self.rentAmount)!)
            
            let period = Int((Stay_Timeframe.text)!)
            
            print(rent!)
            
            
            let totalAmount = String(rent! * period!)
            
            self.bookingData = ["AD_Title": self.Ad_Title!,
                                "User_Id": (userID)!,
                                "Period":(Stay_Timeframe.text)!,
                                "Adult":AdultQuantity!,
                                "Children":ChildrenQuantity!,
                                "Infant":InfantQunatity!,
                                "Pet":PetStatus!,
                                "Message":(messageText.text)!,
                                "Total Amount":totalAmount]
            
            performSegue(withIdentifier: "PAYMENT_SEGUE", sender: nil)

        }
        
        else {
            let alert = UIAlertController(title: "Warning", message: "Some Data missing!!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
     
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DATE_SEGUE"
        {
            
            let dest = segue.destination as! DateCheckinVC
            
            dest.dateDelegate = self
            
            
        }
        
        else if segue.identifier == "GUEST_SEGUE"{
            
            let dest = segue.destination as! GuestVC
            
            dest.guestDelegate = self
            
        }
        
        else if segue.identifier == "PAYMENT_SEGUE"{
            let dest = segue.destination as! CheckOutVC
            
            dest.dataDictionarty = bookingData
            
        }
    }
   
    @IBAction func dismiss_Action(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
