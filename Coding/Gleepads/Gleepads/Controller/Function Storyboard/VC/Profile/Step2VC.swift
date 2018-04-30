//
//  Step2VC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 28/04/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import SwiftVideoBackground

class Step2VC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
  
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        try? VideoBackground.shared.play(view: view, videoName: "host", videoType: "mp4")
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
    
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        return UICollectionViewCell()
    }
    
    
}
