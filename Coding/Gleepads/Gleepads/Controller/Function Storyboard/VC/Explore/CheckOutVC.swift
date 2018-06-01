//
//  CheckOutVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 11/04/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class CheckOutVC: UIViewController {

    @IBOutlet weak var cardHolderName: UITextField!
    @IBOutlet weak var monthDetail: UITextField!
    @IBOutlet weak var yearDetail: UITextField!
    @IBOutlet weak var creditCardNumber: UITextField!
    @IBOutlet weak var cvcNumber: UITextField!
    @IBOutlet weak var totalAmount: UILabel!
    
    var dataDictionarty = [String : String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalAmount.text = "$ \((dataDictionarty["Total Amount"])!)"
        
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
//                        self.dismiss(animated: true, completion: nil)
                    self.present( UIStoryboard(name: "Function", bundle: nil).instantiateViewController(withIdentifier: "Function_First_View") as UIViewController, animated: true, completion: nil)

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
