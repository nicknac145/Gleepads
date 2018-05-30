//
//  amenitiesListVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 30/05/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import Firebase

class amenitiesListVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

 
    @IBOutlet weak var AmentiesList: UITableView!
    var AD_title : String?
    
    var amenitiesArray = [String]()
    var dbHandle : DatabaseHandle!
    var dbRef : DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        AmentiesList.dataSource = self
        AmentiesList.delegate = self
        print(AD_title!)
        
        dbRef = Database.database().reference()
        
        dbHandle = dbRef.child("Hosting").observe(.childAdded, with: { (AmenitiesSnapShot) in
            
            let Amenitiesvalue = AmenitiesSnapShot.value as! [String : String]
            
            if self.AD_title == Amenitiesvalue["AD_Title"]{
            
                
                
            let amenitiesString = (Amenitiesvalue["Amenities"])!
                
                let array = amenitiesString.split(separator: ",")
                
//                self.amenitiesArray = String(array)
                
                for loop in 0...(array.count - 1){
                    
                    self.amenitiesArray.append(String(array[loop]))
                    
                    print(self.amenitiesArray)
                }

        }
            self.AmentiesList.reloadData()
        })
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return amenitiesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Amenities_List", for: indexPath) as! AmentiesListCell
        
        let amenitiesName = self.amenitiesArray[indexPath.row]
        cell.AmenitiesTitle.text = amenitiesName
        cell.AmenitiesImage.image = UIImage(named: amenitiesName)
        return cell
    }

}
