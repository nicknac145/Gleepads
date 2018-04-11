//
//  PropertyTableVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 09/04/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class PropertyTableVC: UITableViewController,ZGCarouselDelegate, UICollectionViewDelegate,UICollectionViewDataSource{
   
    
    var IMAGE = [#imageLiteral(resourceName: "dundee1"),#imageLiteral(resourceName: "dundee2"),#imageLiteral(resourceName: "dundee3"),#imageLiteral(resourceName: "dundee4")]

    @IBOutlet weak var scroll_image: ZGCarousel!
    
    @IBOutlet var propertyTable: UITableView!
    

    @IBOutlet weak var Similar_collection: UICollectionView!
    
    
    var timer:Timer!
    var count = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        scroll_image.zgDelegate = self
        
        propertyTable.delegate = self
        propertyTable.dataSource = self
        
        Similar_collection.delegate = self
        Similar_collection.dataSource = self
        
        
        self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.updateImage), userInfo: nil, repeats: true)
        
        
        let bottomViewNib = Bundle.main.loadNibNamed("PropertyBottomView", owner: nil, options: nil)?.first as! PropertyBottomView
        bottomViewNib.frame.origin.y = self.view.frame.size.height - bottomViewNib.frame.size.height
        bottomViewNib.frame.size.width = self.view.frame.size.width
         UIApplication.shared.keyWindow?.addSubview(bottomViewNib)
        
        

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    
    @objc func updateImage(){
        count+=1
        if count >= IMAGE.count{
            count = 0
        }
        scroll_image.moveTo(index: count)
        
    }
    
    
    
    
    func ZGitemData() -> [UIViewController] {
        
        
        var totalController = [UIViewController]()
        
        
        for totalImage in IMAGE{
            
            let cont = UIStoryboard(name: "Function", bundle: nil).instantiateViewController(withIdentifier: "image") as! ImageScrollVC
            cont.loadView()
            
            cont.displayImage.image = totalImage
            
            totalController.append(cont)
            
        }
        
        
        return totalController
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Similar_Home", for: indexPath) as! Similar_CollectionCell
        
        return cell
        
    }
    
    @IBAction func dismiss_Action(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func share_Action(_ sender: Any) {
        let shareActivity = UIActivityViewController(activityItems: ["www.gleepad.com"], applicationActivities: nil)
        
        shareActivity.popoverPresentationController?.sourceView = self.view
        self.present(shareActivity, animated: true, completion: nil)
        
        
        
    }
    
}
    
    
    
  
