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


class BookingVC: UIViewController, dateFetching {
   
    
    
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
    
    var dateValue = "DD/MM/YYYY"
    
    var dbHandle : DatabaseHandle!
    var dbRef : DatabaseReference!
    var Ad_Title : String?
    
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
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DATE_SEGUE"
        {
            
            let dest = segue.destination as! DateCheckinVC
            
            dest.dateDelegate = self
            
            
        }
    }
   
    @IBAction func dismiss_Action(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
