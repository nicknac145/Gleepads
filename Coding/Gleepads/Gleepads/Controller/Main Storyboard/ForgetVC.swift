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
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    // **************  BACKGROUND VIDEO PLAYER ***************
        try? VideoBackground.shared.play(view: view, videoName: "forget", videoType: "mp4")

    }

    @IBAction func nextButton(_ sender: Any) {
    
        
        // ************** SEGUE TO INITIAL VIEW CONTROLLER  ***************

        let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainVC

        let navController = UINavigationController(rootViewController: mainVC)
        self.present(navController, animated: true, completion: nil)
  
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    
}
