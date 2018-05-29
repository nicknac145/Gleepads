//
//  SearchBarVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 03/04/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
//import Shift
import Firebase


class SearchBarVC: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate {
 
    

   
    @IBOutlet weak var searchResultTable: UITableView!
   
//    var  searchData = ["karachi", "lahore"]
    var searchData = [ DiscoveryData]()
    
    var dbHandle : DatabaseHandle!
    var dbRef : DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchResultTable.delegate = self
        searchResultTable.dataSource = self

        
    let searchVC = UISearchController(searchResultsController: nil)
        
        searchVC.searchBar.placeholder = "Find Your Desire Place?"
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchVC
        self.navigationController?.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationController?.navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
        
        
       
        searchResultTable.reloadData()
    
    }


    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchBar", for: indexPath) as! searchTableCell
        cell.selectionStyle = .none
        tableView.separatorStyle = .none
        
        
//        if searchData[indexPath.row].AD_Title.isEmpty{
//            let alert = UIAlertController(title: "NO FOUND", message: "Unable to find your desire search.", preferredStyle: .alert)
//            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
//            alert.addAction(action)
//            self.present(alert, animated: true, completion: nil)
//
//        }
        
        cell.AD_Title.text = searchData[indexPath.row].AD_Title
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let AD_Title  = searchData[indexPath.row].AD_Title
        let imageString = searchData[indexPath.row].ImageUrl
        
        
        let dataDictionary = ["AdValue" : AD_Title , "ImageValue" : imageString]
        
        
        print(dataDictionary)
        
        
        self.performSegue(withIdentifier: "detail", sender: dataDictionary)
    }
    
  
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail"{
            
            let dest  =  segue.destination as! PropertyTableVC
            
            dest.AD_Dictionary = sender as! Dictionary
        }
    }
    
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchData.removeAll()
        self.searchResultTable.reloadData()
    }
    
  
    
    

 
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchKeyWord = searchBar.text!
        
        print(searchKeyWord)
        dismiss(animated: true, completion: nil)
        
        
        dbRef = Database.database().reference()
        
        dbHandle = dbRef.child("Hosting").observe(.childAdded, with: { (searchSnapShot) in
            
            let value = (searchSnapShot.value) as! [String : String]
            
        
            
            
            if (searchKeyWord.capitalized == value["City"]?.capitalized) || ((value["AD_Title"]?.capitalized.range(of: searchKeyWord.capitalized)) != nil) || (searchKeyWord.capitalized == value["Country"]?.capitalized) {

                let jsonData = try? JSONSerialization.data(withJSONObject: searchSnapShot.value as Any)
                let data = try? JSONDecoder().decode(DiscoveryData.self, from: jsonData!)
                
                self.searchData.append(data!)

            }
          
 
            self.searchResultTable.reloadData()
            
           
        })
        
    
        
      
    }
    
}
