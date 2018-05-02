//
//  Step2VC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 28/04/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import SwiftVideoBackground

class Step2VC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
  
    @IBOutlet weak var addImageLabel: UILabel!
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    var propertyImageArray = [UIImage]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        try? VideoBackground.shared.play(view: view, videoName: "host", videoType: "mp4")
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        
        imageCollectionView.reloadData()
        
        imageCollectionView.isHidden = true
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return propertyImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionCell
        
        cell.propertyImage.image = propertyImageArray[indexPath.row]
        
        
        return cell
        
    }
    
    @IBAction func addImage(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        
        present(imagePicker, animated: true) {
            self.addImageLabel.isHidden = true
            self.imageCollectionView.isHidden = false
        }
      

    }
    
  
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        let selectedImage = info["UIImagePickerControllerOriginalImage"] as! UIImage
        
        propertyImageArray.append(selectedImage)
        dismiss(animated: true, completion: nil)
        
        print(propertyImageArray)
        imageCollectionView.reloadData()
    }
    
    
    
}
