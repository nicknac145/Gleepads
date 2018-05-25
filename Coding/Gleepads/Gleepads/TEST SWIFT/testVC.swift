//
//  testVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 29/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit


class testVC: UIViewController {

   
    @IBOutlet weak var starRating: CosmosView!
    
    @IBOutlet weak var rateValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        starRating.didTouchCosmos = didTouchCosmos(_:)
        starRating.didFinishTouchingCosmos = didFinishTouchCosmos(_:)
        
        rateValue.text = String(starRating.rating)
    }
    
     private func didTouchCosmos(_ rating: Double){
        rateValue.text = String(rating)
    }
    
    private func didFinishTouchCosmos(_ rating: Double){
        
        rateValue.text = String(rating)

    }
    
    
}
