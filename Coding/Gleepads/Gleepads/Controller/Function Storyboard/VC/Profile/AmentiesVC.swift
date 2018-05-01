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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        amenitiesTable.delegate = self
        amenitiesTable.dataSource = self
        
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

        }
        else{
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
        }
    }
    @IBAction func proceedButton(_ sender: Any) {
    }
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
