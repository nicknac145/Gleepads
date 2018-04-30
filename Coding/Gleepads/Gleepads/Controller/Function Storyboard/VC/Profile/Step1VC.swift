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
  
    @IBOutlet weak var propertiesSelectionView: UIView!
    @IBOutlet weak var propertyTF: UITextField!
    @IBOutlet weak var amenitiesTF: UITextField!
    
    @IBOutlet weak var adTitle: UITextField!
    @IBOutlet weak var minDay: UITextField!
    @IBOutlet weak var descrip: UITextView!
    
    var PickerView = UIPickerView()
    var selectedTF : String?
    
    var propertyType = ["Properties","Flat","Single Unit", "Bungalow","Room Sharing"]
    
    
    
    
    
    var amenitiesType = ["Amenities",
                         "Backyard",
                         "420 friendly",
                         "Concert Ready",
                         "Noise Friendly",
                         "Walk-in closet in master bedroom",
                         "Laundry room",
                         "Low-E windows",
                         "Programmable thermostat",
                         "Granite countertop in the kitchen",
                         "Central island in the kitchen",
                        "Bathrooms",
                        "Front porch",
                        "Outdoor kitchen (cooking, refrigerators and sinks)",
                        "Laminate countertops in the kitchen",
                        "Outdoor fireplace",
                        "Sunroom",
                        "Two-story family room",
                        "Media room",
                        "Two-story foyer",
                        "Wedding Friendly",
                        "Party Friendly",
                        "Birthday Friendly"
                         ]
    
    var pickerContent = ["select"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // ***********  Video Player ***************

        try? VideoBackground.shared.play(view: view, videoName: "host", videoType: "mp4")

        PickerView.dataSource = self
        PickerView.delegate = self
        self.propertyTF.delegate=self
        self.amenitiesTF.delegate=self
        
//        let propertyTapped = UITapGestureRecognizer(target: self, action: #selector(enablePicker))
//        propertyTapped.name = "property"
//        propertyTF.addGestureRecognizer(propertyTapped)
//
//        let amenitiestapped = UITapGestureRecognizer(target: self, action: #selector(enablePicker))
//        amenitiestapped.name = "amenties"
//        amenitiesTF.addGestureRecognizer(amenitiestapped)

        print(selectedTF)
        
//        if selectedTF == "property"{
//            self.pickerContent = self.propertyType
//        }
//        else {
//
//            self.pickerContent = self.amenitiesType
//        }
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.propertyTF {
            self.propertyTF.inputView = self.PickerView

        }else{
            self.amenitiesTF.inputView = self.PickerView

        }
        self.PickerView.reloadAllComponents()

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print(pickerView.inputView == self.propertyTF)
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
//    @objc func enablePicker(recog : UIGestureRecognizer){
//        
//        self.selectedTF = recog.name!
//        PickerView.reloadAllComponents()
//
//        propertiesSelectionView.isHidden = false
//        view.endEditing(true)
//  
//    }
    
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
    
    @IBAction func selectButton(_ sender: Any) {
    }
    
    @IBAction func cancelButton(_ sender: Any) {
    }
    
}
