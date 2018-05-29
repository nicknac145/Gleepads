//
//  exploreCollectionVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 28/05/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class exploreCollectionVC: UIViewController, UITableViewDataSource,UITableViewDelegate {


    
    @IBOutlet weak var exploreCollection: UITableView!
    
    var Country_Name = ""
    var imageString = ""

    
    var dataDictionary = ["AdValue" : "" , "ImageValue" : ""]

    var dbRef : DatabaseReference!
    var dbHandle : DatabaseHandle!
    
    
    var dataCollection = [ DiscoveryData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        exploreCollection.delegate = self
        exploreCollection.dataSource = self
        
        print(Country_Name)
        
        dbRef = Database.database().reference()
        dbHandle = dbRef.child("Hosting").observe(.childAdded, with: { (countrySnapShot) in
            
            let recieveData = countrySnapShot.value as! [String:String]
            
            
            if self.Country_Name == (recieveData["Country"])!{
                
                let jsonData = try? JSONSerialization.data(withJSONObject: countrySnapShot.value as Any)
                let data = try? JSONDecoder().decode(DiscoveryData.self, from: jsonData!)

                self.dataCollection.append(data!)
                
            }
            self.exploreCollection.reloadData()
        })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exploreCollection", for: indexPath) as! Explore_Collection_Cell
        
        
        cell.selectionStyle = .none
        tableView.separatorStyle = .none
        cell.AD_Title_Label.text = dataCollection[indexPath.row].AD_Title
        
        let imageString = dataCollection[indexPath.row].ImageUrl
        
        let splitString = imageString.split(separator: ",")
        
        let singleString = splitString[2] 
        let imageURl = URL(string: String(singleString))
        
        cell.AD_Image.sd_setImage(with: imageURl, placeholderImage: UIImage(named: "thumbnail"), options: .progressiveDownload, completed: nil)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let AD_Title  = dataCollection[indexPath.row].AD_Title
        let imageString = dataCollection[indexPath.row].ImageUrl
        
        
        let dataDictionary = ["AdValue" : AD_Title , "ImageValue" : imageString]
        
        
        print(dataDictionary)
        
        
        self.performSegue(withIdentifier: "detail", sender: dataDictionary)
      
    }
   
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
       if segue.identifier == "detail"{
            
            let dest  =  segue.destination as! PropertyTableVC
            
            dest.AD_Dictionary = sender as! Dictionary
        }
    }


    
}
