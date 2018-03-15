//
//  Custom_Button.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 15/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

@IBDesignable class Custom_Button: UIButton {

    
    // ****** Setting Corner Radius ***********
    @IBInspectable var cornerRadius : CGFloat = 0{
        
        didSet{
            
            layer.cornerRadius = cornerRadius
        
        }
        
    }
    
    // ******* Setting Border Color *******
    @IBInspectable var border_color : UIColor = UIColor.clear {
        
        didSet{
            layer.borderWidth = 1
        
            layer.borderColor = border_color.cgColor
        }
    }

}
