//
//  Step3VC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 28/04/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import SwiftVideoBackground



protocol TimeDelegate {
    func setCheckTime(Time: String)
}

class Step3VC: UIViewController,UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, TimeDelegate {
   
    
    func setCheckTime(Time: String) {
        if timeSettingFor == "IN"{
            
            Check_In_label.textColor = UIColor.black
            Check_In_label.text = Time
        }
        else if timeSettingFor == "OUT"{
            Check_Out_label.textColor = UIColor.black

            Check_Out_label.text = Time
        }
    }
    

    // ************ OUTLET **********************
    @IBOutlet weak var rentTF: UITextField!
    @IBOutlet weak var enableSwitch: UISwitch!
    @IBOutlet weak var minSuggestAmount: UILabel!
    @IBOutlet weak var SuggestSlider: UISlider!
    @IBOutlet weak var maxSuggestAmount: UILabel!
    @IBOutlet weak var paymentModeTF: UITextField!
    @IBOutlet weak var guestNumber: UITextField!
    @IBOutlet weak var Check_In_label: UILabel!
    @IBOutlet weak var Check_Out_label: UILabel!
    
    
    
    // ********* VARIABLE THAT WILL BE USE WITH  VC
    
    var PickerView = UIPickerView()
    var PaymentType = ["Visa","Master Card","American Express", "Cryptocurrency" ]
    var timeSettingFor : String?
    
    // *********** INITIALIZE HOSTVC DELEGATE

    var hostDelegate :step3Delegate?
    

    
    
    override func viewDidLoad() {
       
        super.viewDidLoad()

// ************ BACKGROUND VIDEO PLAYER ***************
        try? VideoBackground.shared.play(view: view, videoName: "host", videoType: "mp4")

      paymentModeTF.delegate = self
        PickerView.dataSource = self
        PickerView.delegate = self
        
        
        // ********* TAPPING GESTURE *************
        let CheckINtapped = UITapGestureRecognizer(target: self, action: #selector(SetTime))
        CheckINtapped.name = "IN"
        Check_In_label.addGestureRecognizer(CheckINtapped)

        let CheckOUTtapped = UITapGestureRecognizer(target: self, action: #selector(SetTime))
        CheckOUTtapped.name = "OUT"
        Check_Out_label.addGestureRecognizer(CheckOUTtapped)

    
        enableSwitch.isOn = false
        SuggestSlider.isEnabled = false
        minSuggestAmount.isHidden = true
        maxSuggestAmount.isHidden = true
        
        minSuggestAmount.text = "10.0"
        maxSuggestAmount.text = "100.0"
        
    }
    
    
    // ********* SET-TIME METHOD  ON TAP
    @objc func SetTime(recog : UIGestureRecognizer){
        
        var recogName = recog.name!
        
        if recogName == "IN"{
            performSegue(withIdentifier: "Time_Segue", sender: self)
            
            timeSettingFor = "IN"
        }
        else {
            performSegue(withIdentifier: "Time_Segue", sender: self)
            timeSettingFor = "OUT"
        }
    }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.paymentModeTF {
            self.paymentModeTF.inputView = self.PickerView
            self.PickerView.reloadAllComponents()
       
        }
       
    }
    
    

   
 //************* PICKERVIEW DELEGATE METHOD ***********
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return PaymentType.count

    }
    
    
    // ****** ENTITLE PICKERVIEW *************
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //       return pickerView  == self.propertyTF ? propertyType[row] : amenitiesType[row]
        return PaymentType[row]
        
    }
    
    
    //*********** SELECT VLAUE FROM PICKERVIEW *************
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        paymentModeTF.text = PaymentType[row]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! TimeController
        
        dest.delegate = self
    }
    
    
    // *********** PROCEED BUTTON ACTION *********************
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
    
    
    @IBAction func enableButtonAction(_ sender: UISwitch) {
        if sender.isOn == true{
            
// let amount = ((Float(maxSuggestAmount.text!)! - Float(minSuggestAmount.text!)! ) * sender.value ) + Float(minSuggestAmount.text!)!
//            rentTF.text = String(amount)
            SuggestSlider.isEnabled = true
            minSuggestAmount.isHidden = false
            maxSuggestAmount.isHidden = false
        }
        else{
            SuggestSlider.isEnabled = false
            minSuggestAmount.isHidden = true
            maxSuggestAmount.isHidden = true
        }
    }
    @IBAction func SliderAction(_ sender: UISlider) {
        
        print(sender.value)
        
        let amount = ((Float(maxSuggestAmount.text!)! - Float(minSuggestAmount.text!)! ) * sender.value ) + Float(minSuggestAmount.text!)!
        rentTF.text = String(amount)
        
        
    }
    
}
