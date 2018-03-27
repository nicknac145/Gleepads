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



    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    
        // *********** BACKGROUND VIDEO PLAYER  ***************

        try? VideoBackground.shared.play(view: view, videoName: "Social", videoType: "mp4")
    }

    @IBAction func cancel_action(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
