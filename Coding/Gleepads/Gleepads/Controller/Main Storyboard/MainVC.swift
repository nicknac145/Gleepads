//
//  MainVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 14/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import SafariServices
import SwiftVideoBackground

class MainVC: UIViewController {

 // ***********  variable ***************
    @IBOutlet weak var bottomLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

 // ***********  Configuration Navigation bar setting ***************
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
 // *********** Initialize Tapped function and add to bottomLabel  ***************
        let labelTapped = UITapGestureRecognizer(target: self, action: #selector(labelTouch))
        bottomLabel.addGestureRecognizer(labelTapped)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        // *********** BACKGROUND VIDEO PLAYER   ***************

        try? VideoBackground.shared.play(view: view, videoName: "intro", videoType: "mp4")
        
    }
    
    
    // *********** LOGIN BUTTON ACTION FUNCTION  ***************

    @IBAction func login_action(_ sender: Any) {
        performSegue(withIdentifier: "LoginSegue", sender: self)
    }
    
    
    // ***********   FUNCTION THAT DEFINE ACTION ON TAPPING ***************

    @objc func labelTouch(reccog: UIGestureRecognizer){

        let url = URL(string: "https://www.google.com")
    
        let svc = SFSafariViewController(url: url!)
        self.present(svc, animated: true, completion: nil)
    
    }
    

}

