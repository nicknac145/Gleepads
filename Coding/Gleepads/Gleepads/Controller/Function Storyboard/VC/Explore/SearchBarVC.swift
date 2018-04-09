//
//  SearchBarVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 03/04/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
//import Shift


class SearchBarVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        let view = self.view as! ShiftView
//        view.setColors([UIColor.yellow,
//                        UIColor.brown,
//                        UIColor.orange,
//                        UIColor.red,
//                        UIColor.blue,
//                        UIColor.purple,
//                        UIColor.cyan,
//                        UIColor.green,
//           
//            ])
//        
//        
//        view.startTimedAnimation()
    let searchVC = UISearchController(searchResultsController: nil)
        
        searchVC.searchBar.placeholder = "Where to?"
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchVC
        self.navigationController?.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationController?.navigationItem.searchController = searchVC
    }


    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
