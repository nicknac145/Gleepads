//
//  testVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 20/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import SwiftVideoBackground

class testVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        try? VideoBackground.shared.play(view: view, videoName: "myVideo", videoType: "mp4")

        // Do any additional setup after loading the view.
        
    }


}
