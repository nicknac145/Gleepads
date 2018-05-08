//
//  TimeController.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 08/05/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class TimeController: UIViewController {

    @IBOutlet weak var timePicker: UIDatePicker!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(setTime), for: .valueChanged)
//
        
    }

    
   @objc func setTime(){
    
    let formatter = DateFormatter()
    formatter.dateFormat = "hh:mm a"
    
    let time = formatter.string(from: self.timePicker.date)
    print(time)
    }
    
    
    @IBAction func DismissButton(_ sender: Any) {
        

    }
    

}
