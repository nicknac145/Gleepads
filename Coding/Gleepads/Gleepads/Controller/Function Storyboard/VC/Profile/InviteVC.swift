//
// InviteVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 24/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
//import Shift

class InviteVC: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var inviteTable: UITableView!
    
    //*********** STRUCT TO MANAGE DATA IN CELL WILL HOLD *************
    struct Cell_info {
        let cell : Int
        let image : UIImage?
        let Title : String?
        let Sub_Title  : String?
    }
    
    
    // ********** VARIABLE ***********

    var dataArray = [Cell_info]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inviteTable.delegate = self
        inviteTable.dataSource = self

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

         dataArray = [ Cell_info(cell: 1, image: nil, Title: nil, Sub_Title: "Just 4 steps left"),
                       Cell_info(cell: 2, image: #imageLiteral(resourceName: "right_pointer.png"), Title: nil, Sub_Title: "Your travel credit"),
                       Cell_info(cell: 2, image: #imageLiteral(resourceName: "right_pointer.png"), Title: nil, Sub_Title: "Read terms and conditions"), ]

        
    }


    // HANDLE NUMBER OF CELL
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
 
    
    // HANDLE WHAT DATA TO BE SHOWN TO WHICH CELL.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if dataArray[indexPath.row].cell == 1{
            let cell = Bundle.main.loadNibNamed("InviteTableViewCell", owner: self, options: nil)?.first as! InviteTableViewCell
            
            return cell
        }
        else{
        let cell = Bundle.main.loadNibNamed("ButtonTableViewCell", owner: self, options: nil)?.first as! ButtonTableViewCell
        cell.buttonTitle.text = dataArray[indexPath.row].Sub_Title
        cell.buttonImage.image = dataArray[indexPath.row].image
        return cell
        }
    }
    
    
    // SETTING HEIGHT OF RESPECTIVE CELL
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if dataArray[indexPath.row].cell == 1{
           
            return 312
            
        }
        else{
        
            
            return 75
        }
    }
}
