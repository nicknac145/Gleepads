//
//  AmentiesVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 01/05/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class AmentiesVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var amenitiesTable: UITableView!
    
    var amenitiesType = [
                         "Backyard",
                         "420 friendly",
                         "Concert Ready",
                         "Noise Friendly",
                         "Walk-in closet in master bedroom",
                         "Laundry room",
                         "Low-E windows",
                         "Programmable thermostat",
                         "Granite countertop in the kitchen",
                         "Central island in the kitchen",
                         "Shared-Bathrooms",
                         "Attached-Bathroom",
                         "Front porch",
                         "Outdoor kitchen (cooking refrigerators and sinks)",
                         "Laminate countertops in the kitchen",
                         "Outdoor fireplace",
                         "Sunroom",
                         "Two-story family room",
                         "Media room",
                         "Two-story foyer",
                         "Wedding Friendly",
                         "Party Friendly",
                         "Birthday Friendly"
    ]
    
    
    var Delegate : amentiesDelegate?
    
    var step1 = Step1VC()
     var selectedAmenties = [String]()
    var selectedIndex = [Int]()
    
    var textfieldAmenties = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        amenitiesTable.delegate = self
        amenitiesTable.dataSource = self
        
        amenitiesTable.reloadData()
        
        self.amenitiesTable.allowsMultipleSelection=true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return amenitiesType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "checkboxCell", for: indexPath) as! checkboxCell
        cell.Title.text = amenitiesType[indexPath.row]
        cell.selectionStyle = .none

        if self.selectedIndex.contains(indexPath.row){
            cell.checkbox.image = #imageLiteral(resourceName: "checkbox.png")
        }else{
            cell.checkbox.image = #imageLiteral(resourceName: "uncheckbox.png")
        }
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
   let  check = tableView.cellForRow(at: indexPath) as! checkboxCell
        check.checkbox.image = #imageLiteral(resourceName: "checkbox.png")
        self.selectedIndex.append(indexPath.row)
        
        print(self.selectedIndex)
        
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        
        
        if let i = self.selectedIndex.index(of: indexPath.row) {
            let check = tableView.cellForRow(at: indexPath) as! checkboxCell
            check.checkbox.image = #imageLiteral(resourceName: "uncheckbox.png")
            self.selectedIndex.remove(at: i)

            
        }
        
        print(self.selectedIndex)

    }
    
    
    
    @IBAction func proceedButton(_ sender: Any) {
        
        for value in selectedIndex{
            
            
            let temp = value
           
            let amenties = amenitiesType[temp]
            self.textfieldAmenties = self.textfieldAmenties + "\(amenties),"
            self.selectedAmenties.append(amenties)
            
            
        }
//        print(self.textfieldAmenties)
//        print(selectedAmenties)
        
        
        
        self.dismiss(animated: true) {
            self.Delegate?.amenities(value: self.selectedAmenties, title: self.selectedAmenties.joined(separator: ","))

        }
    }
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
   
    
}
