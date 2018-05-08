//
//  Step3VC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 28/04/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import SwiftVideoBackground

class Step3VC: UIViewController,UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    
    @IBOutlet weak var rentTF: UITextField!
    @IBOutlet weak var enableSwitch: UISwitch!
    @IBOutlet weak var minSuggestAmount: UILabel!
    @IBOutlet weak var SuggestSlider: UISlider!
    @IBOutlet weak var maxSuggestAmount: UILabel!
 
    @IBOutlet weak var paymentModeTF: UITextField!
    @IBOutlet weak var guestNumber: UITextField!

    @IBOutlet weak var Check_In_label: UILabel!
    @IBOutlet weak var Check_Out_label: UILabel!
    
    
    var PickerView = UIPickerView()
    var PaymentType = ["Visa","Master Card","American Express", ]
    
    
    var hostDelegate :step3Delegate?
    

    
    
    override func viewDidLoad() {
       
        super.viewDidLoad()


        try? VideoBackground.shared.play(view: view, videoName: "host", videoType: "mp4")

      paymentModeTF.delegate = self
        PickerView.dataSource = self
        PickerView.delegate = self
        
        let CheckINtapped = UITapGestureRecognizer(target: self, action: #selector(SetTime))
        CheckINtapped.name = "IN"
        Check_In_label.addGestureRecognizer(CheckINtapped)

        let CheckOUTtapped = UITapGestureRecognizer(target: self, action: #selector(SetTime))
        CheckOUTtapped.name = "OUT"
        Check_Out_label.addGestureRecognizer(CheckOUTtapped)

    
        
    }
    @objc func SetTime(recog : UIGestureRecognizer){
        
        var recogName = recog.name!
        
        if recogName == "IN"{
            performSegue(withIdentifier: "Time_Segue", sender: self)
        }
        else {}
    }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.paymentModeTF {
            self.paymentModeTF.inputView = self.PickerView
            self.PickerView.reloadAllComponents()
       
        }
       
    }
    
   
 
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return PaymentType.count

    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //       return pickerView  == self.propertyTF ? propertyType[row] : amenitiesType[row]
        return PaymentType[row]
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        paymentModeTF.text = PaymentType[row]
    }
    
    
    @IBAction func proceedButton(_ sender: Any) {
        
        
        if (rentTF.text?.isEmpty)! == false && (paymentModeTF.text?.isEmpty)! == false && (guestNumber.text?.isEmpty)! == false && (Check_In_label.text!.isEmpty) == false && (Check_Out_label.text?.isEmpty)! == false{
            
            hostDelegate?.DataColletion(Rent: rentTF.text!, PaymentMode: paymentModeTF.text!, Guest: guestNumber.text!, Check_In: Check_In_label.text!, Check_Out: Check_Out_label.text!)
            
            
            self.navigationController?.popViewController(animated: true)
        }
        
        else{
            let alert = UIAlertController(title: "Some Value Missing!", message: "You are missing some textField", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
        }
 

    }
    
}
