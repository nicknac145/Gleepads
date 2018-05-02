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
                         "Bathrooms",
                         "Front porch",
                         "Outdoor kitchen (cooking, refrigerators and sinks)",
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
    
    
    var step1 = Step1VC()
     var selectedAmenties = [String]()
    var selectedIndex = [Int]()
    
    var textfieldAmenties = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        amenitiesTable.delegate = self
        amenitiesTable.dataSource = self
        
        amenitiesTable.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return amenitiesType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = amenitiesType[indexPath.row]
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
            
            for i in selectedIndex{
               
                if indexPath.row == i{
                    selectedIndex.remove(at: i)
                    
                    print(selectedIndex)
                }
            }

        }
        else{
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            selectedIndex.append(indexPath.row)
            
            print(selectedIndex)
        }
    }
    
    
    
    
    
    @IBAction func proceedButton(_ sender: Any) {
        
        for value in selectedIndex{
            
            
            let temp = value
           
            let amenties = amenitiesType[temp]
            self.textfieldAmenties = self.textfieldAmenties + "\(amenties),"
            self.selectedAmenties.append(amenties)
            
            
        }
        print(self.textfieldAmenties)
        print(selectedAmenties)
        
        
        self.dismiss(animated: true) {
                    self.step1.amenitiesTF.text = self.textfieldAmenties

        }
    }
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
   
    
}
