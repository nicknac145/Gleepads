//
//Custom_View.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 19/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

@IBDesignable class Custom_View: UIView {

    @IBInspectable var C_Radius : CGFloat = 0 {
        didSet{
            layer.cornerRadius = C_Radius
            
        }
        
    }
}
