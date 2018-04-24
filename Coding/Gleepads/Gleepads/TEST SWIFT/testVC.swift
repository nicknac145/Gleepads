//
//  testVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 29/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class testVC: UIViewController {

    @IBOutlet weak var dob: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    dob.datePickerMode = .date
      
    }

    @IBAction func action(_ sender: Any) {
        let f = DateFormatter()
        f.dateFormat = "dd-MM-YYYY"
        let d = f.string(from: dob.date)
        self.dateLabel.text = d
    }
    

}
