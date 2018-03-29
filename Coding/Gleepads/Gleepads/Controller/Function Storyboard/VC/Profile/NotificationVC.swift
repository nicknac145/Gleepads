//
//  NotificationVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 24/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import Shift

class NotificationVC: UIViewController {

    @IBOutlet weak var NotifyTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let view = self.view as! ShiftView
        view.setColors([UIColor.yellow,
                        UIColor.brown,
                        UIColor.orange,
                        UIColor.red,
                        UIColor.blue,
                        UIColor.purple,
                        UIColor.cyan,
                        UIColor.green,
                        //                        UIColor.lightGray,
            ])
        view.startTimedAnimation()
    }

 

}
