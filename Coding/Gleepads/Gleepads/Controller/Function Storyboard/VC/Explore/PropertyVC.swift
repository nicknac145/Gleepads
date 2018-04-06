//
//  PropertyVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 06/04/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class PropertyVC: UIViewController, UITableViewDataSource,UITableViewDelegate,ZGCarouselDelegate {
    
    

    @IBOutlet weak var propertyTable: UITableView!
  
    
    var IMAGE = [#imageLiteral(resourceName: "dundee1"),#imageLiteral(resourceName: "dundee2"),#imageLiteral(resourceName: "dundee3"),#imageLiteral(resourceName: "dundee4")]
   
    var timer:Timer!
    var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.propertyTable.delegate=self
        self.propertyTable.dataSource=self
        
        self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.updateImage), userInfo: nil, repeats: true)
    }

    @objc func updateImage(){
        count+=1
        if count >= IMAGE.count{
            count = 0
        }
        let cell = self.propertyTable.cellForRow(at: IndexPath(row: 0, section: 0)) as! imageScrollCell
        cell.ScrolledImage.moveTo(index: count)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageScroll") as! imageScrollCell
        cell.ScrolledImage.zgDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    func ZGitemData() -> [UIViewController] {
        
        
        var totalController = [UIViewController]()
        
        
        for totalImage in IMAGE{
            
            let cont = UIStoryboard(name: "Function", bundle: nil).instantiateViewController(withIdentifier: "image") as! ImageScrollVC
            cont.loadView()

            cont.displayImage.image = totalImage

            totalController.append(cont)

        }
        
//        cont.displayImage.image = #imageLiteral(resourceName: "dundee1")
//        let cont1 = UIStoryboard(name: "Function", bundle: nil).instantiateViewController(withIdentifier: "image") as! ImageScrollVC
       return totalController
        
    }
    
}
