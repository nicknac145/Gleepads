//
//  TripVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 28/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
//import  Shift

class TripVC: UIViewController {

    @IBOutlet weak var exploreButton: Custom_Button!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let view = self.view as! ShiftView
//        view.setColors([UIColor.yellow,
//                        UIColor.brown,
//                        UIColor.orange,
//                        UIColor.red,
//                        UIColor.blue,
//                        UIColor.purple,
//                        UIColor.cyan,
//                        UIColor.green,
//                        //                        UIColor.lightGray,
//            ])
//        view.startTimedAnimation()

    }

    @IBAction func exploreButton(_ sender: Any) {
        

        self.tabBarController?.selectedIndex = 0
        
    }
    

}
