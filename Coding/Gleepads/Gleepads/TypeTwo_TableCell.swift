//
//  TypeTwo_TableCell.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 30/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class TypeTwo_TableCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    

    @IBOutlet weak var TypeTwo_Title: UILabel!
    @IBOutlet weak var TypeTwo_SubTitle: UILabel!
    @IBOutlet weak var TypeTwo_Collection: UICollectionView!
    
    @IBOutlet weak var TypeTwo_Button: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        TypeTwo_Collection.delegate = self
        TypeTwo_Collection.dataSource = self
        let TypeTwo_Nib = UINib(nibName: "TypeTwo_CollectionViewCell", bundle: nil)
        self.TypeTwo_Collection.register(TypeTwo_Nib, forCellWithReuseIdentifier: "TypeTwo_Nib")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypeTwo_Nib", for: indexPath)
        return cell
    }

    @IBAction func TypeTwo_Button_Action(_ sender: Any) {
    }
  
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 365, height:285)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
