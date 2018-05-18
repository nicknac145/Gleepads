//
//  TypeOne_TableCell.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 30/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit



class TypeOne_TableCell: UITableViewCell {
    

    @IBOutlet weak var TypeOne_Label: UILabel!
    @IBOutlet weak var TypeOne_Collection: UICollectionView!
    
 

    

    
    override func awakeFromNib() {
        super.awakeFromNib()
       
//        TypeOne_Collection.delegate = self
//        TypeOne_Collection.dataSource = self
//        let TypeOne_Nib = UINib(nibName: "TypeOne_CollectionViewCell", bundle: nil)
//        self.TypeOne_Collection.register(TypeOne_Nib, forCellWithReuseIdentifier: "TypeOne_Nib")
        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
