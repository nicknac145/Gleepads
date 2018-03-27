//
//  ForgetVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 19/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import SwiftVideoBackground

class ForgetVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        try? VideoBackground.shared.play(view: view, videoName: "myVideo", videoType: "mp4")


        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        try? VideoBackground.shared.play(view: view, videoName: "forget", videoType: "mp4")

    }

    @IBAction func nextButton(_ sender: Any) {
    
        let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainVC

        let navController = UINavigationController(rootViewController: mainVC)
        self.present(navController, animated: true, completion: nil)
  
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    
}
