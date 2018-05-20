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
import SDWebImage

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


    var cellType = 0
    var cityName = [String]()
    var cityAD = [String]()
    
    var displayAD = [String]()
//    var cityData = [[String:Any]]()
//    var exploreData = ["Explore"]
//    var suggesData = ["Suggest"]
//    var hostData = ["Hosting"]
    
    var exploreData = [String]()
    var suggesData = [String]()
    var hostData = [String]()
    
    // FIREBASE
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

        dbRef = Database.database().reference()


        // ********** EXPLORE VALUE ****************
        dbHandle = dbRef.child("Explore").observe(.value, with: { (SnapShot) in
            
            if  SnapShot != nil {

                self.exploreValue = SnapShot.value as! [String : String]

//                print("******* EXPLORE *******")
//                print(self.exploreValue)
//                print("***************")

                for explore in self.exploreValue{

                    self.exploreData.append(explore.value)

//                    print(self.exploreData)

                }


            }
            self.exploreTable.reloadData()

        })



        // ********** SUGGESTED VALUE ****************
        dbHandle = dbRef.child("Suggested").observe(.value, with: { (SnapShot) in
            if  SnapShot != nil {

                self.suggestedValue = SnapShot.value as! [String : String]

//                print("******* SUGGESGTED *******")
//                print(self.suggestedValue)
//                print("***************")

                for suggested in self.suggestedValue{
//                    print(suggested.value)
//                    self.suggesData.append(suggested.value)
//                    print(self.suggesData)

                }
            }
            self.exploreTable.reloadData()

        })

        // ********** HOSTING VALUE ****************
        let Uid = (Auth.auth().currentUser?.uid)!

        dbHandle = dbRef.child("Hosting").observe(.childAdded, with: { (SnapShot) in

            if  SnapShot != nil {

                self.hostingValue = SnapShot.value as! [String : String]

//                print("****** HOST ******")
//                print(self.hostingValue)
//                print("***************")

                for hosting in self.hostingValue{

//                    print(hosting)

//                    self.hostData.append(hosting.value)
//                   self.exploreTable.reloadData()

                }


            }
            self.exploreTable.reloadData()

        })
        
        
        // ********** HOSTING VALUE ****************

        
        // FETCHING KEY INFO FROM CITY NODE
        dbHandle = dbRef.child("City").observe(.childAdded, with: { (cityinfo) in
            
        
            self.cityName.append(cityinfo.key as! String)
           print(self.cityName)
            
            
            
            // FETCHING DATA FROM CITY NODE
            self.dbHandle = self.dbRef.child("City").child(cityinfo.key).observe(.childAdded, with: { (cityValue) in
               
                
                var data = cityValue.value  as! [String : Any]
                
                var name = data["AD-Title"] as! String
//                var userId = data["User_Uid"] as! String

                self.cityAD.append(name)
                
                print(self.cityAD)
                
//                self.cityData.append(["City": self.cityName, "AD" : self.cityAD])
//                
//                print(self.cityData)
                

                
                self.dbHandle = self.dbRef.child("Hosting").observe(.childAdded, with: { (hostingData) in
                  
                    
//                    print(hostingData.value)
                        
                        
                   
                    self.exploreTable.reloadData()
                    
                })
            })
            
            
//            if  SnapShot != nil {
//
//                self.hostingValue = SnapShot.value as! [String : String]
//
//                print("****** HOST ******")
//                print(self.hostingValue)
//                print("***************")
//
//                for hosting in self.hostingValue{
//
//                    //                    print(hosting)
//
//                    //                    self.hostData.append(hosting.value)
//                    //                   self.exploreTable.reloadData()
//
//                }
//
//
//            }
//            self.exploreTable.reloadData()
            
        })
     
       
    
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let SearchNib = Bundle.main.loadNibNamed("SearchBar", owner: self, options: nil)?.first as! SearchBar
        
        self.navigationItem.titleView = SearchNib
        
        let searchTap = UITapGestureRecognizer(target: self, action: #selector(searchVC))
        SearchNib.addGestureRecognizer(searchTap)


        
        
        exploreTable.delegate = self
        exploreTable.dataSource = self
        

        
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
       
        
        self.cellType = indexPath.row
        
        
        //*******************  Suggesting CELL ****************
        if indexPath.row == 0{
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypeOne_TableCell") as! TypeOne_TableCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none

            
            
//            print("|||||||||||||||||||||||||||")
//
//            print(exploreData)
//            print("|||||||||||||||||||||||||||")
            
            
            

            cell.exploreCollectionData = exploreData
//            cell.TypeOne_Collection.delegate = self
//            cell.TypeOne_Collection.dataSource = self
//
//            let TypeOne_Nib = UINib(nibName: "TypeOne_CollectionViewCell", bundle: nil)
//            cell.TypeOne_Collection.register(TypeOne_Nib, forCellWithReuseIdentifier: "TypeOne_Nib")
////            cell.TypeOne_Collection.reloadData()
            
            return cell
        }
        
           
            
            
            //*******************  EXPLORE CELL ****************

        else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypeTwo_TableCell") as! TypeTwo_TableCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
   
            
            return cell
        }
            
          
            
            
            //*******************  HOSTING CELL ****************

       
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypeThree_TableCell") as! TypeThree_TableCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none

            cell.TypeThree_Collection.delegate=self
            cell.TypeThree_Collection.dataSource=self
            
            let TypeThree_Nib = UINib(nibName: "TypeThree_CollectionViewCell", bundle: nil)
            cell.TypeThree_Collection.register(TypeThree_Nib, forCellWithReuseIdentifier: "TypeThree_Nib")
//            cell.TypeThree_Collection.reloadData()
            
            return cell
        }
      
     
    }
    
    
    
    
    //************************* TABLE HEIGHT SETTING ******************
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        
        if indexPath.row == 0{
            return 240
            
            
        }
        else if indexPath.row == 1 {
            
           return 375
        }
        
        return 575

    }
    
   
    
    // **************** Function use for scroll  DATE & Guest Button ********************
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.endingOffset = scrollView.contentOffset.y
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
     
//         ************* MOVE TO TOP ********************

        if (self.endingOffset < scrollView.contentOffset.y) {

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
    

    
}





//*************** EXTENSION *****************************

extension ExploreVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
   
    
    
  
    // ***************** COLLECTION VIEW NUMBER OF ITEM ****************************

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

            return 4

    }
    
    
    
    // ***************** COLLECTION VIEW CELL FOR ITEM ****************************

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypeThree_Nib", for: indexPath) as! TypeThree_CollectionViewCell
//        cell.TypeThree_Caption.text = hostData[indexPath.row]
        return cell
//
    
    }
    
    
    
    // ***************** COLLECTION VIEW SIZE ****************************
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width:150, height: 230)

    }


    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        self.performSegue(withIdentifier: "detail", sender: nil)
        
    }
    
    

  
}
