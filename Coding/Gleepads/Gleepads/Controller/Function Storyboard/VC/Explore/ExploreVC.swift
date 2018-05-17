//
//  ExploreVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 29/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
//import Shift

import Firebase

class ExploreVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {


    
    @IBOutlet weak var exploreTable: UITableView!
    
    @IBOutlet weak var buttonView: UIView!
    
    @IBOutlet weak var dateButton: Custom_Button!
    
    @IBOutlet weak var guestButton: UIButton!
    
    var endingOffset : CGFloat = 0
    
    var dbRef : DatabaseReference!
    var dbHandle : DatabaseHandle!

    
    var exploreValue = ["":""]
    var hostingValue = ["":""]
    var suggestedValue = ["":""]
    var userValue = ["":""]

    
    
    // FIREBASE
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbRef = Database.database().reference()
        
        
        // ********** EXPLORE VALUE ****************
        dbHandle = dbRef.child("Explore").observe(.value, with: { (SnapShot) in
            if  SnapShot != nil {
                
                self.exploreValue = SnapShot.value as! [String : String]

                print("******* EXPLORE *******")
                print(self.exploreValue)
                print("***************")

            }
        })
        
        
        // ********** HOSTING VALUE ****************
        let Uid = (Auth.auth().currentUser?.uid)!

        dbHandle = dbRef.child("Hosting").observe(.childAdded, with: { (SnapShot) in
            
//            print(SnapShot.value)
            if  SnapShot != nil {

                self.hostingValue = SnapShot.value as! [String : String]

//                print("****** HOST ******")
//                print(self.hostingValue)
//                print("***************")

            }
        })
     
        // ********** SUGGESTED VALUE ****************
        dbHandle = dbRef.child("Suggested").observe(.value, with: { (SnapShot) in
            if  SnapShot != nil {

                self.suggestedValue = SnapShot.value as! [String : String]

                print("******* SUGGESGTED *******")
                print(self.suggestedValue)
                print("***************")

            }
        })
    
        
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
            cell.selectionStyle = UITableViewCellSelectionStyle.none

//            cell.TypeOne_Collection.
            
            return cell
        }
        
        else if indexPath.row == 1 || indexPath.row % 3 == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypeTwo_TableCell") as! TypeTwo_TableCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none

            return cell
        }
       
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypeThree_TableCell") as! TypeThree_TableCell
            let TypeThree_Nib = UINib(nibName: "TypeThree_CollectionViewCell", bundle: nil)
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none

            cell.TypeThree_Collection.register(TypeThree_Nib, forCellWithReuseIdentifier: "TypeThree_Nib")
            cell.TypeThree_Collection.delegate=self
            cell.TypeThree_Collection.dataSource=self
            return cell
        }
      
     
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 240
            
            
        }
        else if indexPath.row == 1 || indexPath.row % 3 == 0{
            
           return 375
        }
        return 575

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
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "PropertyVC")
//        self.navigationController?.pushViewController(vc!, animated: true)
//    }
    
}


extension ExploreVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
   
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypeThree_Nib", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:150, height: 230)
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        self.performSegue(withIdentifier: "detail", sender: nil)
        
    }
}
