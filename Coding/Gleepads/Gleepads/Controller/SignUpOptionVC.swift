//
//  SignUpOptionVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 15/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import SwiftVideoBackground

class SignUpOptionVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        try? VideoBackground.shared.play(view: view, videoName: "myVideo", videoType: "mp4")

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        try? VideoBackground.shared.play(view: view, videoName: "myVideo", videoType: "mp4")
        
    }

    @IBAction func cancel_action(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
