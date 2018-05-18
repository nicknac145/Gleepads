//
//  TypeTwo_TableCell.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 30/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class TypeTwo_TableCell: UITableViewCell {

    

    @IBOutlet weak var TypeTwo_Title: UILabel!
    @IBOutlet weak var TypeTwo_SubTitle: UILabel!
    @IBOutlet weak var TypeTwo_Collection: UICollectionView!
    
    @IBOutlet weak var TypeTwo_Button: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
     

    }
    
    @IBAction func TypeTwo_Button_Action(_ sender: Any) {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
