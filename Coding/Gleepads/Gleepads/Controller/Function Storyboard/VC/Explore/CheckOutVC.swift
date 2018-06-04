//
//  CheckOutVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 11/04/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import Firebase

class CheckOutVC: UIViewController {

    @IBOutlet weak var cardHolderName: UITextField!
    @IBOutlet weak var monthDetail: UITextField!
    @IBOutlet weak var yearDetail: UITextField!
    @IBOutlet weak var creditCardNumber: UITextField!
    @IBOutlet weak var cvcNumber: UITextField!
    @IBOutlet weak var totalAmount: UILabel!
    
    var dataDictionary = [String : String]()
    
    var dbRef : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalAmount.text = "$ \((dataDictionary["Total Amount"])!)"
        
//        print("*********************")
//
//        print("----------------")
//        print(dataDictionarty)
//        print("----------------")
//
//        print("*********************")

    }

    @IBAction func purchaseButton(_ sender: Any) {
        
        
        if (cardHolderName.text != "") && (monthDetail.text != "")  && (yearDetail.text != "")  && (creditCardNumber.text != "")  && (cvcNumber.text != ""){
            
        
            let alert = UIAlertController(title: "CONFIRM", message: "Some Data missing!!", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "CONFIRM", style: .default) { (alertAction) in
                
                self.dataDictionary["CardHolder"] = self.cardHolderName.text!
                self.dataDictionary["Month_CC"] = self.monthDetail.text!
                self.dataDictionary["Year_CC"] = self.yearDetail.text!
                self.dataDictionary["CreditCard"] = self.creditCardNumber.text!
                self.dataDictionary["CVC"] = self.cvcNumber.text!
                self.dataDictionary["Bill"] = self.totalAmount.text!
                
                print("**********************")
                print(self.dataDictionary)
                print("**********************")

                
//                self.present( UIStoryboard(name: "Function", bundle: nil).instantiateViewController(withIdentifier: "Function_First_View") as UIViewController, animated: true, completion: nil)
                
                self.present(UIStoryboard(name: "Function", bundle: nil).instantiateViewController(withIdentifier: "Function_First_View") as UIViewController, animated: true, completion: {
                    self.dbRef = Database.database().reference()
                    self.dbRef.child("Booking").childByAutoId().setValue(self.dataDictionary)
                })

            }
            let cancelAction = UIAlertAction(title: "CANCEL", style: .default, handler: nil)
            alert.addAction(confirmAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            
            

            
        }
            
        else {
            let alert = UIAlertController(title: "Warning", message: "Some Data missing!!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
}
