//
//  SuggestedCollectionVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 28/05/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class SuggestedCollectionVC: UIViewController, UITableViewDelegate,UITableViewDataSource {


    @IBOutlet weak var suggestedCollection: UITableView!
   
    var City_Name = ""
    var imageString = ""
    
    
    var dataDictionary = ["AdValue" : "" , "ImageValue" : ""]

    
    
    
    var dbRef : DatabaseReference!
    var dbHandle : DatabaseHandle!
    
    
    var dataCollection = [DiscoveryData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print("*************************")
//        print(City_Name)
//        print("*************************")
        // Do any additional setup after loading the view.
        
        suggestedCollection.delegate = self
        suggestedCollection.dataSource = self
        
        
        dbRef = Database.database().reference()
        dbHandle = dbRef.child("Hosting").observe(.childAdded, with: { (citySnapShot) in
            
            let recieveData = citySnapShot.value as! [String:String]
            
            
            if self.City_Name == (recieveData["City"])!{
                
                let jsonData = try? JSONSerialization.data(withJSONObject: citySnapShot.value as Any)
                let data = try? JSONDecoder().decode(DiscoveryData.self, from: jsonData!)
                print("*************************")

                print (data?.City)
                print("*************************")

                self.dataCollection.append(data!)
                
            }
            self.suggestedCollection.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "suggestionCollection", for: indexPath) as! Suggested_Collection_Cell
        
        
        cell.selectionStyle = .none

        cell.AD_Title_Label.text = dataCollection[indexPath.row].AD_Title
    
        let imageString = dataCollection[indexPath.row].ImageUrl

        let splitString = imageString.split(separator: ",")

        let singleString = splitString[0]
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
        return 104
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detail"{
            
            let dest  =  segue.destination as! PropertyTableVC
            
            dest.AD_Dictionary = sender as! Dictionary
        }
    }



}
