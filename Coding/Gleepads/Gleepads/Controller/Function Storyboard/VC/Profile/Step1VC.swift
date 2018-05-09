//
//  Step1VC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 28/04/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import SwiftVideoBackground



// ********** CREATING AMENITIES DELEGATE ************

protocol amentiesDelegate {
   
    func amenities(value : [String], title: String)
}





class Step1VC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate, amentiesDelegate,UITextViewDelegate {
    
    
    
    // ********** INITIALIZE AMENITIES DELEGATE METHOD *************
    
    func amenities(value: [String], title: String) {
        
        self.selectedAmenties = value
        self.amenitiesTF.text = title
        
        amenities = title
   
    }
    
  // *********** OUTLET **********
    @IBOutlet weak var propertyTF: UITextField!
    @IBOutlet weak var amenitiesTF: UITextField!
    
    @IBOutlet weak var adTitle: UITextField!
    @IBOutlet weak var minDay: UITextField!
    @IBOutlet weak var descrip: UITextView!
    
    
    // ************ VARIABLE THAT WILL BE PLAY VITAL ROLE IN THIS VC ****************
    var PickerView = UIPickerView()
    var selectedTF : String?
    var selectedAmenties = [String]()
    var propertyType = ["Properties","Flat","Single Unit", "Bungalow","Room Sharing"]
    
    // ******** INITIALIZE STEP1VC DELEGATE***********
    var hostDelegate : step1Delegate?
    
    // ********** VARIABLE THAT HOLD VALUE FROM STEP1 VC VIA DELEGATE *************
    var adtitle : String?
    var propertyCategory : String?
    var amenities : String?
    var mininumDay : String?
    var propertyDescription : String?
    
 
    
    var pickerContent = ["select"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // ***********  Video Player ***************

        try? VideoBackground.shared.play(view: view, videoName: "host", videoType: "mp4")

    
        PickerView.dataSource = self
        PickerView.delegate = self
        self.propertyTF.delegate=self
        self.amenitiesTF.delegate=self
        self.descrip.delegate = self


     
//
        
    }
    
 
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
       
        // *** ENABLE PICKERVIEW FOR PROPERTY SELECTION **********
        if textField == self.propertyTF {
            self.propertyTF.inputView = self.PickerView
            self.PickerView.reloadAllComponents()

// ***** SEGUE TO COLLECT AMENITIES VALUE *******
        }else{
            performSegue(withIdentifier: "Amenities_Segue", sender: self)

        }

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.propertyTF {
            self.propertyTF.inputView = nil
            self.PickerView.reloadAllComponents()
        }
        adtitle = adTitle.text
        propertyCategory = propertyTF.text
        mininumDay =  minDay.text
        propertyDescription = descrip.text

        
        print(mininumDay)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        mininumDay =  minDay.text
        propertyDescription = descrip.text

    }
   
    
    // ******** PICKERVIEW DELEGATE METHODS *********
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        return propertyType.count

    }
    
    
    // *******  ASSIGN TITLE TO PICKERVIEW ****************
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        return propertyType[row]
      
    }
    
    
    // *********** SELECT DESIRE VALUE  *********
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
        

        // *********** ASSIGN VALUE TO HOST DELEGATE METHOD ********
        hostDelegate?.DataColletion(propertyTitle: adtitle!, propertyCatergory: propertyCategory!, propertyAmenities: amenities!, propertyMininum: mininumDay!, propertyDescription: propertyDescription!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let amenitiesSegue = segue.destination as! AmentiesVC
        
        amenitiesSegue.Delegate = self
    }
}
