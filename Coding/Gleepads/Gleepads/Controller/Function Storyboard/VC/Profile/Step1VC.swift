//
//  Step1VC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 28/04/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import SwiftVideoBackground

class Step1VC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {
  
    @IBOutlet weak var propertyTF: UITextField!
    @IBOutlet weak var amenitiesTF: UITextField!
    
    @IBOutlet weak var adTitle: UITextField!
    @IBOutlet weak var minDay: UITextField!
    @IBOutlet weak var descrip: UITextView!
    
    var PickerView = UIPickerView()
    var selectedTF : String?
    
    var propertyType = ["Properties","Flat","Single Unit", "Bungalow","Room Sharing"]
    
    
    
    
    
 
    
    var pickerContent = ["select"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // ***********  Video Player ***************

        try? VideoBackground.shared.play(view: view, videoName: "host", videoType: "mp4")

        PickerView.dataSource = self
        PickerView.delegate = self
        self.propertyTF.delegate=self
        self.amenitiesTF.delegate=self
        


        print(selectedTF)
        
//
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.propertyTF {
            self.propertyTF.inputView = self.PickerView
            self.PickerView.reloadAllComponents()


        }else{
            view.endEditing(true)
            performSegue(withIdentifier: "Amenities_Segue", sender: self)

        }

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.propertyTF {
            self.propertyTF.inputView = nil
            self.PickerView.reloadAllComponents()
            
            
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return pickerView.inputView == self.propertyTF ? propertyType.count : amenitiesType.count
        return propertyType.count

    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//       return pickerView  == self.propertyTF ? propertyType[row] : amenitiesType[row]
        return propertyType[row]
      
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    propertyTF.text = propertyType[row]
    }
//
    
    @IBAction func proceedButton(_ sender: Any) {
        
        if (adTitle.text?.isEmpty)! == false && (propertyTF.text?.isEmpty)! == false && (amenitiesTF.text?.isEmpty)! == false && (minDay.text?.isEmpty)! == false && descrip.text.isEmpty == false{

            self.navigationController?.popViewController(animated: true)
        }

        else{

            print("MISSING VALUE")

            print((adTitle.text?.isEmpty)!)
            print((propertyTF.text?.isEmpty)!)
            print((amenitiesTF.text?.isEmpty)!)
            print((minDay.text?.isEmpty)!)
            print(descrip.text.isEmpty)
        }
    }
}
