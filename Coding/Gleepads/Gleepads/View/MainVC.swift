//
//  MainVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 14/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import SafariServices

class MainVC: UIViewController {

    @IBOutlet weak var bottomLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        
        let labelTapped = UITapGestureRecognizer(target: self, action: #selector(labelTouch))
        bottomLabel.addGestureRecognizer(labelTapped)
    }
    
    
    @IBAction func login_action(_ sender: Any) {
        performSegue(withIdentifier: "NewAccountSegue", sender: self)
    }
    
    @objc func labelTouch(reccog: UIGestureRecognizer){

        let url = URL(string: "https://www.google.com")
    
        let svc = SFSafariViewController(url: url!)
        self.present(svc, animated: true, completion: nil)
    
    }

}

