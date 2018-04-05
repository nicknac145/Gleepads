//
//  InboxVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 29/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
//import Shift

class InboxVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    struct Cell_info {
        let cell : Int
        let image : UIImage?
        let Title : String?
        let Sub_Title  : String
    }
    
    
   var dataArray = [Cell_info]()
    
    
    
    @IBOutlet weak var inboxTable: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let view = self.view as! ShiftView
//        view.setColors([UIColor.yellow,
//                        UIColor.brown,
//                        UIColor.orange,
//                        UIColor.red,
//                        UIColor.blue,
//                        UIColor.purple,
//                        UIColor.cyan,
//                        UIColor.green,
//            ])
//        view.startTimedAnimation()
        inboxTable.delegate = self
        inboxTable.dataSource = self
    
        dataArray = [Cell_info(cell: 1, image: nil, Title: "Inbox", Sub_Title: "You have no unread messages")]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if dataArray[indexPath.row].cell == 1{
            let cell = Bundle.main.loadNibNamed("TopTableViewCell", owner: self, options: nil)?.first as! TopTableViewCell
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            cell.TitleLabel.text = dataArray[indexPath.row].Title
            cell.subTitleLabel.text = dataArray[indexPath.row].Sub_Title
            
            
            return cell
            
        }
        else{
            let cell = UITableViewCell()
            cell.textLabel?.text = "YOU Message"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if dataArray[indexPath.row].cell == 1{
            return 108
            
        }
  
        else{
            return 10
        }
    }
}
