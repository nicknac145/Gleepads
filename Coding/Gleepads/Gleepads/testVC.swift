//
//  testVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 26/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import BubbleTransition

class testVC: UIViewController,UIViewControllerTransitioningDelegate {

    @IBOutlet weak var testButton: UIButton!
    
    let transition = BubbleTransition()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "second")
//            self.present(vc!, animated: true, completion: nil)
            self.performSegue(withIdentifier: "second", sender: self)

        }
    
    }
    @IBAction func action(_ sender: Any) {
        
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "second")
//        self.present(vc!, animated: true, completion: nil)
    }
    
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination 
        controller.transitioningDelegate = self
        controller.modalPresentationStyle = .custom
    }
    
    // MARK: UIViewControllerTransitioningDelegate
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        
        transition.transitionMode = .present
        transition.startingPoint = testButton.center
//        transition.bubbleColor = testButton.backgroundColor!
        return transition
    }
    
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
////        transition.transitionMode = .present
////        transition.startingPoint = someButton.center
////        transition.bubbleColor = someButton.backgroundColor!
////        return transition
//    }

}
