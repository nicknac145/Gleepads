//
//  MainVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 14/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func login_action(_ sender: Any) {
        performSegue(withIdentifier: "login", sender: self)
    }
    
   


}

