//
//  ExploreVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 29/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import Shift

class ExploreVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

//    struct celldata{
//
//        var Image : UIImage?
//        var Title : String?
//        var Sub-Title1: String?
//        var Sub-Title2: String?
//        var Sub-Title3: String?
//
//
//    }
    
//    var data = [celldata]()
    
    @IBOutlet weak var exploreTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        exploreTable.delegate = self
        exploreTable.dataSource = self
        
        let view = self.view as! ShiftView
        view.setColors([UIColor.yellow,
                        UIColor.brown,
                        UIColor.orange,
                        UIColor.red,
                        UIColor.blue,
                        UIColor.purple,
                         UIColor.cyan,
                        UIColor.green,
//                        UIColor.lightGray,
                        ])
        view.startTimedAnimation()
        
        let nib = UINib(nibName: "smallCollectionTC", bundle: nil)
        self.exploreTable.register(nib, forCellReuseIdentifier: "smallCollection")

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "smallCollection") as! smallCollectionTC

//        cell.collectionView
        return cell
        
     
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 106
    }
    
}
