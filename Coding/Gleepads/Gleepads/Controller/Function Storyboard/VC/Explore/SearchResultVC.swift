//
//  SearchResultVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 26/04/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class SearchResultVC: UIViewController,UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var dateButton: Custom_Button!
    @IBOutlet weak var guestButton: UIButton!
    @IBOutlet weak var resultTableView: UITableView!
    var endingOffset : CGFloat = 0
    
    
    
    var dump = ["1","2","3","4","5","6","1","2","3","4","5","6","1","2","3","4","5","6"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    resultTableView.delegate = self
    resultTableView.dataSource = self
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return dump.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = dump[indexPath.row]
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.endingOffset = scrollView.contentOffset.y
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //         ************* MOVE TO TOP ********************
        
        if (self.endingOffset < scrollView.contentOffset.y) {
            //
            UIView.animate(withDuration: 0.7) {
                self.buttonView.frame.origin.y = -28
                
                self.dateButton.alpha = 0
                self.guestButton.alpha = 0
                
            }
        }
    
            
            // ************* MOVE TO BOTTOM ********************
            
        else if (self.endingOffset > scrollView.contentOffset.y) {
            
            
            UIView.animate(withDuration: 0.7) {
                self.buttonView.frame.origin.y = 0
                self.dateButton.alpha = 1
                self.guestButton.alpha = 1
                
            }
        }
        
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    


}
