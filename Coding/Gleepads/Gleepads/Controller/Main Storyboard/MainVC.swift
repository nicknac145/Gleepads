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

    @IBOutlet weak var bottomLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        


        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        
        let labelTapped = UITapGestureRecognizer(target: self, action: #selector(labelTouch))
        bottomLabel.addGestureRecognizer(labelTapped)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        try? VideoBackground.shared.play(view: view, videoName: "intro", videoType: "mp4")
        
    }
    
    @IBAction func login_action(_ sender: Any) {
        performSegue(withIdentifier: "LoginSegue", sender: self)
    }
    
    @objc func labelTouch(reccog: UIGestureRecognizer){

        let url = URL(string: "https://www.google.com")
    
        let svc = SFSafariViewController(url: url!)
        self.present(svc, animated: true, completion: nil)
    
    }
    

}

