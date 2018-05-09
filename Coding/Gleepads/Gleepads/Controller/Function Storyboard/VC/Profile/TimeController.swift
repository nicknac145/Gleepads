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
    
    var selectedTime : String?
    
    var delegate : TimeDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(setTime), for: .valueChanged)
//
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        let time = formatter.string(from: self.timePicker.date)
        self.selectedTime = time

        
        
    }

    // ************  Extract selected time ************
   @objc func setTime(){
    
    let formatter = DateFormatter()
    formatter.dateFormat = "hh:mm a"
    
    let time = formatter.string(from: self.timePicker.date)
    print(time)
    self.selectedTime = time
    }
    
    @IBAction func DoneButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        self.delegate?.setCheckTime(Time: self.selectedTime!)
    }
    
    @IBAction func DismissButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    

}
