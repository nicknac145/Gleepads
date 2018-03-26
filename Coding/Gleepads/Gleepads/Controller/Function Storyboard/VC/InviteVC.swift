//
// InviteVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 24/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class InviteVC: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var inviteTable: UITableView!
    
    
    struct Cell_info {
        let cell : Int
        let image : UIImage?
        let Title : String?
        let Sub_Title  : String?
    }
    
    var dataArray = [Cell_info]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inviteTable.delegate = self
        inviteTable.dataSource = self

        
         dataArray = [ Cell_info(cell: 1, image: nil, Title: nil, Sub_Title: "Just 4 steps left"), Cell_info(cell: 2, image: #imageLiteral(resourceName: "right_pointer.png"), Title: nil, Sub_Title: "Your travel credit"), Cell_info(cell: 2, image: #imageLiteral(resourceName: "right_pointer.png"), Title: nil, Sub_Title: "Read terms and conditions"), ]

        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
 
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if dataArray[indexPath.row].cell == 1{
           
            return 312
            
        }
        else{
        
            
            return 75
        }
    }
}
