//
//  GuestVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 05/04/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class GuestVC: UIViewController {

    
    
    @IBOutlet weak var BGView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()


        let exitTap = UITapGestureRecognizer(target: self, action: #selector(exit))
        BGView.addGestureRecognizer(exitTap)
    
    }

    @objc func exit(recog : UIGestureRecognizer){
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
