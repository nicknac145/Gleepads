//
//  SettingVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 24/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class SettingVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    struct Cell_info {
        let cell : Int
        let image : UIImage?
        let Title : String?
        let Sub_Title  : String?
    }
    
    var vcName = [String]()
    
    @IBOutlet weak var settingTable: UITableView!
    
    var dataArray = [Cell_info]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingTable.delegate = self
        settingTable.dataSource = self

        dataArray = [Cell_info(cell: 1, image: nil, Title: nil, Sub_Title: nil),
                     Cell_info(cell: 2, image: #imageLiteral(resourceName: "right_pointer.png"), Title: "Notification", Sub_Title: nil),
                     Cell_info(cell: 3, image: nil, Title: "Currency", Sub_Title: "USD($)"),
                     Cell_info(cell: 2, image: #imageLiteral(resourceName: "right_pointer.png"), Title: "Payment methods", Sub_Title: nil),
                     Cell_info(cell: 2, image: #imageLiteral(resourceName: "right_pointer.png"), Title: "Terms of Service", Sub_Title: nil),
                     Cell_info(cell: 3, image: nil, Title: "Version 1.0", Sub_Title: nil),
                     Cell_info(cell: 3, image: nil, Title: "Log Out", Sub_Title: nil),
        ]
        
        
        vcName = ["Notification_Setting",
                  "Currency",
                  "Payment",
                  "Term",
                  "Version",
                  "logout"]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if dataArray[indexPath.row].cell == 1{
            let cell =  Bundle.main.loadNibNamed("HeadingCell", owner: self, options: nil)?.first as! HeadingCell
           
            
            return cell
        }
        else if dataArray[indexPath.row].cell == 2{
            let cell =  Bundle.main.loadNibNamed("ButtonTableViewCell", owner: self, options: nil)?.first as! ButtonTableViewCell
            cell.buttonImage.image = dataArray[indexPath.row].image
            cell.buttonTitle.text = dataArray[indexPath.row].Title
            
            return cell
        }
        else{
            let cell =  Bundle.main.loadNibNamed("ButtonTableViewCell", owner: self, options: nil)?.first as! ButtonTableViewCell
            cell.buttonTitle.text = dataArray[indexPath.row].Title
            cell.buttonSubTitle.text = dataArray[indexPath.row].Sub_Title

            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if dataArray[indexPath.row].cell == 1{
         
            
            return 72
        }
        else if dataArray[indexPath.row].cell == 2{
           
            
            return 75
        }
        else{
            
            
            return 75
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row >= 1 && indexPath.row  <= 4{
            
            let VC = vcName[(indexPath.row)-1]
            let controller = storyboard?.instantiateViewController(withIdentifier: VC)
            self.navigationController?.pushViewController(controller!, animated: true)
        }
         }


}
