//
//  LaunchedVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 24/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import SwiftVideoBackground
import BubbleTransition

class LaunchedVC: UIViewController,UIViewControllerTransitioningDelegate {

    
    @IBOutlet weak var gleepad: UIImageView!
    
    // ***********  Background initializa variable ***************
    @IBOutlet weak var background: UIImageView!
    
    // ******* just dummy button required by BuubleTransition POD *********
    @IBOutlet weak var segueButton: UIButton!
    let transition = BubbleTransition()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.gleepadIncImage.alpha = 0
// ***********  variable that store time Video commence ***************
        var current_time = DispatchTime.now()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.7) {
        
        current_time = DispatchTime.now()
            self.background.isHidden = true
        }
        
        
 // ***********  Video Player ***************
        try? VideoBackground.shared.play(view: view, videoName: "couple", videoType: "mp4")
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
            UIView.animate(withDuration: 5) {
                self.gleepad.alpha = 0
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 13) {
            self.gleepad.image = UIImage(named: "Gleepads_witout_BG")

            UIView.animate(withDuration: 3) {

//                self.gleepadIncImage.alpha = 1
                self.gleepad.alpha = 1

            }
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: current_time + 16) {
//            VideoBackground.shared.pause()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.performSegue(withIdentifier: "Enter", sender: self)

            })

        }
    }
    
 // ***********  Function where circular transition is introduce ***************
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination
        controller.transitioningDelegate = self
        controller.modalPresentationStyle = .custom
    }
    
 // ***********  Transition Implemented ***************
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        
        transition.transitionMode = .present
        transition.startingPoint = segueButton.center
        return transition
    }
 

}
