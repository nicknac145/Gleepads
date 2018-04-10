//
//  ExploreVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 29/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
//import Shift

class ExploreVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {


    
    @IBOutlet weak var exploreTable: UITableView!
    
    @IBOutlet weak var buttonView: NSLayoutConstraint!
   
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    var endingOffset : CGFloat = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let SearchNib = Bundle.main.loadNibNamed("SearchBar", owner: self, options: nil)?.first as! SearchBar
        
        self.navigationItem.titleView = SearchNib
        
        let searchTap = UITapGestureRecognizer(target: self, action: #selector(searchVC))
        SearchNib.addGestureRecognizer(searchTap)


        
        
        exploreTable.delegate = self
        exploreTable.dataSource = self
        
//        let view = self.view as! ShiftView
//        view.setColors([UIColor.yellow,
//                        UIColor.brown,
//                        UIColor.orange,
//                        UIColor.red,
//                        UIColor.blue,
//                        UIColor.purple,
//                         UIColor.cyan,
//                        UIColor.green,
////                        UIColor.lightGray,
//                        ])
//
//
//        view.startTimedAnimation()
        
        let One_nib = UINib(nibName: "TypeOne_TableCell", bundle: nil)
        self.exploreTable.register(One_nib, forCellReuseIdentifier: "TypeOne_TableCell")
        
        let Two_nib = UINib(nibName: "TypeTwo_TableCell", bundle: nil)
        self.exploreTable.register(Two_nib, forCellReuseIdentifier: "TypeTwo_TableCell")
        
        let Three_nib = UINib(nibName: "TypeThree_TableCell", bundle: nil)
        self.exploreTable.register(Three_nib, forCellReuseIdentifier: "TypeThree_TableCell")

    }
    
    
    @objc func searchVC(recog : UIGestureRecognizer){
        
        let searchBarVC = storyboard?.instantiateViewController(withIdentifier: "SearchBarVC")
        
        self.present(searchBarVC!, animated: true, completion: nil)
//        self.navigationController?.pushViewController(searchBarVC!, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypeOne_TableCell") as! TypeOne_TableCell
            
//            cell.TypeOne_Collection.
            
            return cell
        }
        
        else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypeTwo_TableCell") as! TypeTwo_TableCell
//            cell.selectionStyle = UITableViewCellSelectionStyle.none

            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypeThree_TableCell") as! TypeThree_TableCell
            
            return cell
        }
      
     
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 240
            
            
        }
        else if indexPath.row == 1{
            
           return 375
            
        }
        return 575

    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.endingOffset = scrollView.contentOffset.y
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
     
        
        
        // ************* MOVE TO TOP ********************

        if (self.endingOffset < scrollView.contentOffset.y) {
                if (self.buttonBottomConstraint.constant <= 555)
                        {
                            self.buttonBottomConstraint.constant += 1
                        }
        }


            // ************* MOVE TO BOTTOM ********************

        else if (self.endingOffset > scrollView.contentOffset.y) {

                if self.buttonBottomConstraint.constant >= 530
                    {
                        self.buttonBottomConstraint.constant -= 1
                    }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PropertyVC")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
