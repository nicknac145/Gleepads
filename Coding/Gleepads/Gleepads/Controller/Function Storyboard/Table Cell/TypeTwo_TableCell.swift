//
//  TypeTwo_TableCell.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 30/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class TypeTwo_TableCell: UITableViewCell
//    ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{

    

    @IBOutlet weak var TypeTwo_Title: UILabel!
    @IBOutlet weak var TypeTwo_SubTitle: UILabel!
    @IBOutlet weak var TypeTwo_Collection: UICollectionView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

//        TypeTwo_Collection.delegate = self
//        TypeTwo_Collection.dataSource = self
//
//        let TypeTwo_Nib = UINib(nibName: "TypeTwo_CollectionViewCell", bundle: nil)
//        TypeTwo_Collection.register(TypeTwo_Nib, forCellWithReuseIdentifier: "TypeTwo_Nib")
//        //cell.TypeTwo_Collection.reloadData()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//            return 5
//
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypeTwo_Nib", for: indexPath) as! TypeTwo_CollectionViewCell
//
//            return cell
//
//    }
//
//    // ***************** COLLECTION VIEW SIZE ****************************
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
////            return CGSize(width: 350, height:250)
//
//    }
}
