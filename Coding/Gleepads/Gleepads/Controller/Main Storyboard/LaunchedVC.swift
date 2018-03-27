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

    
    
    // ***********  Background initializa variable ***************
    @IBOutlet weak var background: UIImageView!
    
    // ******* just dummy button required by BuubleTransition POD *********
    @IBOutlet weak var segueButton: UIButton!
    let transition = BubbleTransition()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
// ***********  variable that store time Video commence ***************
        var current_time = DispatchTime.now()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.7) {
        
        current_time = DispatchTime.now()
            self.background.isHidden = true
        }
        
        
 // ***********  Video Player ***************
        try? VideoBackground.shared.play(view: view, videoName: "launched_screen", videoType: "mp4")
 
        DispatchQueue.main.asyncAfter(deadline: current_time + 9.5) {
            self.performSegue(withIdentifier: "Enter", sender: self)

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
