//
//  TypeOne_TableCell.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 30/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class TypeOne_TableCell: UITableViewCell, UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
   
 
    @IBOutlet weak var TypeOne_Label: UILabel!
    @IBOutlet weak var TypeOne_Collection: UICollectionView!
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypeOne_Nib", for: indexPath) as! TypeOne_CollectionViewCell
        
        return cell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        TypeOne_Collection.delegate = self
        TypeOne_Collection.dataSource = self
        let TypeOne_Nib = UINib(nibName: "TypeOne_CollectionViewCell", bundle: nil)
        self.TypeOne_Collection.register(TypeOne_Nib, forCellWithReuseIdentifier: "TypeOne_Nib")
        
    }

    
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 150, height: 175)
    }
    
    
    
    
    
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
