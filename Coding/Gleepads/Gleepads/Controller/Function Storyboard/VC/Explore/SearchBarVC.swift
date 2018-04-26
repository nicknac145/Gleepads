//
//  SearchBarVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 03/04/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
//import Shift


class SearchBarVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    

    var dump = ["karachi", "lahore"]
    
    @IBOutlet weak var searchResultTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchResultTable.delegate = self
        searchResultTable.dataSource = self

        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dump.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = dump[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ResultSegue", sender: self)
    }
}
