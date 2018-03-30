//
//  TypeThree_TableCell.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 30/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class TypeThree_TableCell: UITableViewCell , UICollectionViewDataSource,UICollectionViewDelegate{
 

    @IBOutlet weak var TypeThree_Title: UILabel!
    
    @IBOutlet weak var TypeThree_Collection: UICollectionView!
    
    @IBOutlet weak var TypeThree_Button: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        TypeThree_Collection.delegate = self
        TypeThree_Collection.dataSource = self
        let TypeThree_Nib = UINib(nibName: "TypeThree_CollectionViewCell", bundle: nil)
        self.TypeThree_Collection.register(TypeThree_Nib, forCellWithReuseIdentifier: "TypeThree_Nib")
    
    }
    
    
    @IBAction func TypeThree_Button_Action(_ sender: Any) {
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypeThree_Nib", for: indexPath)
        return cell
    }
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
