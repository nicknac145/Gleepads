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
    @IBOutlet weak var checkInTF: UITextField!
    @IBOutlet weak var checkOutTF: UITextField!
    
    
    var PickerView = UIPickerView()
    var PaymentType = ["Visa","Master Card","American Express", ]
  
    
    
    override func viewDidLoad() {
       
        super.viewDidLoad()


        try? VideoBackground.shared.play(view: view, videoName: "host", videoType: "mp4")

      paymentModeTF.delegate = self
        PickerView.dataSource = self
        PickerView.delegate = self
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
        
                let alert = UIAlertController(title: "SUCCESS!", message: "YOU PROPERTY DETAIL HAS BEEN STORED", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
    }
    
}
