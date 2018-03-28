//
//  TripVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 28/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class TripVC: UIViewController {

    @IBOutlet weak var exploreButton: Custom_Button!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func exploreButton(_ sender: Any) {
        

        self.tabBarController?.selectedIndex = 0
        
    }
    

}
