//
//  ExploreVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 29/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import Shift

class ExploreVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {

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
        
        let searchBar = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchBar
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
//        self.navigationController?.navigationItem.searchController = searchBar
//        self.navigationController?.navigationItem.hidesSearchBarWhenScrolling = false
        
        
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
        
        let One_nib = UINib(nibName: "TypeOne_TableCell", bundle: nil)
        self.exploreTable.register(One_nib, forCellReuseIdentifier: "TypeOne_TableCell")
        
        let Two_nib = UINib(nibName: "TypeTwo_TableCell", bundle: nil)
        self.exploreTable.register(Two_nib, forCellReuseIdentifier: "TypeTwo_TableCell")
        
        let Three_nib = UINib(nibName: "TypeThree_TableCell", bundle: nil)
        self.exploreTable.register(Three_nib, forCellReuseIdentifier: "TypeThree_TableCell")

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypeOne_TableCell") as! TypeOne_TableCell
            
            
            return cell
        }
        
        else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypeTwo_TableCell") as! TypeTwo_TableCell
//            cell.selectionStyle = UITableViewCellSelectionStyle.none

            //        cell.collectionView
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypeThree_TableCell") as! TypeThree_TableCell
            
            //        cell.collectionView
            return cell
        }
      
     
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 240
            
            
        }
        else if indexPath.row == 1{
            
           return 375
            
        }
        return 575

    }
    
}
