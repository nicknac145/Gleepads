//
//  testVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 29/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import Shift

class testVC: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = self.view as! ShiftView
        view.setColors([UIColor.orange,
                        UIColor.red,
                        UIColor.blue,
                        UIColor.purple,
                        UIColor.green,
                        UIColor.brown,
                        UIColor.cyan,
                        UIColor.yellow,
                        UIColor.gray,
                        UIColor.lightGray,
                        ])
        view.startTimedAnimation()
    }

 

}
