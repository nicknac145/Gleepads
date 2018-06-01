//
//  GuestVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 05/04/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class GuestVC: UIViewController {

    
    @IBOutlet var button_value: [Custom_Button]!
    @IBOutlet weak var adult_value_label: UILabel!
    @IBOutlet weak var children_value_label: UILabel!
    @IBOutlet weak var infant_value_label: UILabel!
    
    @IBOutlet weak var petSwitch: UISwitch!
    
    var guestDelegate : guestFetching?
    
    var adultQuantity = 1
    var childrenQuantity = 0
    var infantQuantity = 0
    var petStatus = "without"
    
    @IBOutlet weak var BGView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()


        let exitTap = UITapGestureRecognizer(target: self, action: #selector(exit))
        BGView.addGestureRecognizer(exitTap)
    
    }

    @objc func exit(recog : UIGestureRecognizer){
        
        if petSwitch.isOn{
            petStatus = "with"
        }
        else{
            petStatus = "without"

        }
        guestDelegate?.guestValue(Adult: String(adultQuantity), Children: String(childrenQuantity),Infant : String(infantQuantity), Pet: petStatus)
        
        self.dismiss(animated: true, completion: nil)
    }
  
   
    @IBAction func button_actions(_ sender: Custom_Button) {
        
        if sender.tag == 0 && adultQuantity > 0{
            
            adultQuantity -= 1
             adult_value_label.text = String(adultQuantity)
            
        }
        
        else if sender.tag == 1 {
            
            adultQuantity += 1
            
            adult_value_label.text = String(adultQuantity)
        }
        
        else if sender.tag == 2 && childrenQuantity > 0 {
            
            childrenQuantity -= 1
            children_value_label.text = String(childrenQuantity)
        }
        else if sender.tag == 3 {
            
            childrenQuantity += 1
            children_value_label.text = String(childrenQuantity)
        }
        else if sender.tag == 4 && infantQuantity > 0 {
            
            infantQuantity -= 1
            infant_value_label.text = String(infantQuantity)
        }
        else if sender.tag == 5 {
            
            infantQuantity += 1
            infant_value_label.text = String(infantQuantity)
        }
    }
    

}
