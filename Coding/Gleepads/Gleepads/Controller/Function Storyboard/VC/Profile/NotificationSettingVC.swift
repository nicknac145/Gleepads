//
//  NotificationSettingVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 24/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
//import Shift

class NotificationSettingVC: UIViewController, UITableViewDataSource,UITableViewDelegate{

    
    //*********** STRUCT TO MANAGE DATA IN CELL WILL HOLD *************
    struct Cell_info {
        let cell : Int
        let Title : String?
        let Sub_Title  : String?
    }
    
    
    // ********** VARIABLE ***********

    @IBOutlet weak var notificationSettingTable: UITableView!
    var dataArray = [Cell_info]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationSettingTable.delegate = self
        notificationSettingTable.dataSource = self
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        
//
//        let view = self.view as! ShiftView
//        view.setColors([UIColor.yellow,
//                        UIColor.brown,
//                        UIColor.orange,
//                        UIColor.red,
//                        UIColor.blue,
//                        UIColor.purple,
//                        UIColor.cyan,
//                        UIColor.green,
//                        //                        UIColor.lightGray,
//            ])
//        view.startTimedAnimation()
        
        
        
        
        // ********** DATA FOR TABLEVIEW CELL ***********
        
        dataArray = [Cell_info(cell: 1,  Title: "Notification", Sub_Title: nil),
                     Cell_info(cell: 3,  Title: "Push notification", Sub_Title: nil),
                     Cell_info(cell: 2,  Title: "Message", Sub_Title: "Recieve message from hosts & guests, including booking request"),
                     Cell_info(cell: 3,  Title: "Email", Sub_Title: nil),
                     Cell_info(cell: 3,  Title: "Text message", Sub_Title: nil),
                     Cell_info(cell: 2,  Title: "Reminder", Sub_Title: "Recieve booking reminder, requests to write a review, price notices, and other reminder related to your activities on Gleepads"),
                     Cell_info(cell: 3,  Title: "Email", Sub_Title: nil),
                     Cell_info(cell: 3,  Title: "Text message", Sub_Title: nil),
                     Cell_info(cell: 2,  Title: "Promotion and tips", Sub_Title: "Recieve coupons, promotions, surveys, product updates and inspiration from Gleedpads and it's partner"),
                     Cell_info(cell: 3,  Title: "Email", Sub_Title: nil),
                     Cell_info(cell: 3,  Title: "Text message", Sub_Title: nil),
                     Cell_info(cell: 3,  Title: "Phone Call", Sub_Title: nil),
                     Cell_info(cell: 2,  Title: "Policy and community", Sub_Title: "Recieve update on homing sharing regulation and stay informed about advocacy efforts to created fair, reposnsible home sharing laws in your community"),
                     Cell_info(cell: 3,  Title: "Email", Sub_Title: nil),
                     Cell_info(cell: 3,  Title: "Text message", Sub_Title: nil),
                     Cell_info(cell: 3,  Title: "Phone Call", Sub_Title: nil),
                     Cell_info(cell: 2,  Title: "Account support", Sub_Title: "We may need to senf you messages regarding your acoount."),
                     Cell_info(cell: 3,  Title: "Email", Sub_Title: nil),
                     Cell_info(cell: 3,  Title: "Text message", Sub_Title: nil),
        ]

    }

    // HANDLE NUMBER OF CELL
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }

    
    // HANDLE WHAT DATA TO BE SHOWN TO WHICH CELL.

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if dataArray[indexPath.row].cell == 1{
            let cell = Bundle.main.loadNibNamed("TopTableViewCell", owner: self, options: nil)?.first as! TopTableViewCell
            cell.TitleLabel.text = dataArray[indexPath.row].Title
            cell.subTitleLabel.text = dataArray[indexPath.row].Sub_Title

            return cell
            
        }
        else if dataArray[indexPath.row].cell == 2{
            
            let cell = Bundle.main.loadNibNamed("NotifySettingLabelCell", owner: self, options: nil)?.first as! NotifySettingLabelCell
            cell.Title .text = dataArray[indexPath.row].Title
            cell.subTitle.text = dataArray[indexPath.row].Sub_Title
            return cell
        }
        else{
            let cell = Bundle.main.loadNibNamed("NotifySettingSwitchCell", owner: self, options: nil)?.first as! NotifySettingSwitchCell
          
            cell.buttonTitle.text = dataArray[indexPath.row].Title
            return cell
        }
        
        
    }
    
    
    
    // SETTING HEIGHT OF RESPECTIVE CELL
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if dataArray[indexPath.row].cell == 1{
            return 108
            
        }
        else if dataArray[indexPath.row].cell == 2{
            return 106
            
        }
            
        else{
            return 44
        }
    }
}
