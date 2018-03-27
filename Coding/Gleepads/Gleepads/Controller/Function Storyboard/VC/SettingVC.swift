//
//  SettingVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 24/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import SafariServices


class SettingVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //*********** STRUCT TO MANAGE DATA IN CELL WILL HOLD *************
    struct Cell_info {
        let cell : Int
        let image : UIImage?
        let Title : String?
        let Sub_Title  : String?
    }
    
    
    
    // ********** VARIABLE ***********

    var vcName = [String]()
    
    @IBOutlet weak var settingTable: UITableView!
    
    var dataArray = [Cell_info]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem?.title = "<"
        
        
        settingTable.delegate = self
        settingTable.dataSource = self

        
        // ********** DATA FOR TABLEVIEW CELL ***********

        dataArray = [Cell_info(cell: 1, image: nil, Title: nil, Sub_Title: nil),
                     Cell_info(cell: 2, image: #imageLiteral(resourceName: "right_pointer.png"), Title: "Notification", Sub_Title: nil),
                     Cell_info(cell: 3, image: nil, Title: "Currency", Sub_Title: "USD($)"),
                     Cell_info(cell: 2, image: #imageLiteral(resourceName: "right_pointer.png"), Title: "Payment methods", Sub_Title: nil),
                     Cell_info(cell: 2, image: #imageLiteral(resourceName: "right_pointer.png"), Title: "Terms of Service", Sub_Title: nil),
                     Cell_info(cell: 3, image: nil, Title: "Version 1.0", Sub_Title: nil),
                     Cell_info(cell: 3, image: nil, Title: "Log Out", Sub_Title: nil),
        ]
        
        
        
        // *********  NAME OF VIEW-CONTROLLER THAT WILL OPEN SELECTING TABLE CELL *************

        vcName = ["Notification_Setting",
                  "Currency",
                  "Payment",
                  "Term",
                  "Version",
                  "logout"]
    }

    // HANDLE NUMBER OF CELL
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    
    // HANDLE WHAT DATA TO BE SHOWN TO WHICH CELL.
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
    
    
    // SETTING HEIGHT OF RESPECTIVE CELL
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
    
    
    
    // ENABLE "SELECT CELL" FEATURE
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row >= 1 && indexPath.row  <= 3{
            
            let VC = vcName[(indexPath.row)-1]
            let controller = storyboard?.instantiateViewController(withIdentifier: VC)
            self.navigationController?.pushViewController(controller!, animated: true)
        }
        
        else if indexPath.row == 4{
            let url = URL(string: "https://www.google.com")
            
            let svc = SFSafariViewController(url: url!)
            self.present(svc, animated: true, completion: nil)
        }
        
        else if indexPath.row == 6{
            
            let VC = UIAlertController(title:nil, message: nil, preferredStyle: .actionSheet)
            let logoutAction = UIAlertAction(title: "Log Out", style: .default, handler: { (action) in
                self.parent?.parent?.navigationController?.popViewController(animated: true)
                print(self.parent)
            })
            let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            VC.addAction(logoutAction)
            VC.addAction(CancelAction)

            present(VC, animated: true, completion: nil)
        }
        
         }


}
