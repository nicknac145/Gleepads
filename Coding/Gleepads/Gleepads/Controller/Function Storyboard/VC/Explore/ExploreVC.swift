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


    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var exploreTable: UITableView!
    
    @IBOutlet weak var buttonView: UIView!
    
    @IBOutlet weak var dateButton: Custom_Button!
    
    @IBOutlet weak var guestButton: UIButton!
    
  
    var endingOffset : CGFloat = 0
    
    var dbRef : DatabaseReference!
    var dbHandle : DatabaseHandle!

    
    var exploreValue = ["":""]
    var userValue = ["":""]

    var city : String?
    
 
    
    // FIREBASE
    
    var HostingData = [String:[DiscoveryData]]()
    var SuggestedData = [[String:String]]()
    var ExploreData = [[String:String]]()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

        dbRef = Database.database().reference()


        // ********** EXPLORE VALUE ****************
        dbHandle = dbRef.child("Explore").observe(.childAdded, with: { (exploreInfo) in

            let dict = exploreInfo.value as! [String : String]
     
            
            self.ExploreData.append(dict)

            self.exploreTable.reloadData()
        })
        



        // ********** SUGGESTED VALUE ****************
        
        
        dbHandle = dbRef.child("Suggested").observe(.childAdded, with: { (suggestedInfo) in

            

            let dict = suggestedInfo.value as! [String : String]


            self.SuggestedData.append(dict)
//            print("%%%%%%%%%%%%%")
//            print(self.SuggestedData)
//            print("%%%%%%%%%%%%%")
            self.exploreTable.reloadData()
        })
        

        // ********** HOSTING VALUE ****************

        
        // FETCHING KEY INFO FROM CITY NODE
        dbHandle = dbRef.child("Hosting").observe(.childAdded, with: { (info) in
            
//            print(info.value)
        
            let jsonData = try? JSONSerialization.data(withJSONObject: info.value)
            let discovery = try? JSONDecoder().decode(DiscoveryData.self, from: jsonData!)

//            print(discovery)
            
            if let d = discovery {
                if self.HostingData[discovery!.City] == nil {
                    self.HostingData[discovery!.City] = []
                }
                self.HostingData[discovery!.City]!.append(discovery!)
               
                let city  = Array(self.HostingData)
//                print("------------------------")
//                print(self.HostingData.keys)
//                print("------------------------")


            }
            self.exploreTable.reloadData()
        })
     
       
    
        
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
        
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
//        return Array(FirebaseData).count + 2
        return Array(HostingData).count + 2
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        
        
        //*******************  Suggesting CELL ****************
        if indexPath.row == 0{
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypeOne_TableCell") as! TypeOne_TableCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none

            
            // TAGGING COLLECTION-VIEW
            cell.TypeOne_Collection.tag = indexPath.row
            
            
          
           
            
            // CONFIGURE CELL
            cell.TypeOne_Collection.delegate = self
            cell.TypeOne_Collection.dataSource = self
            let TypeOne_Nib = UINib(nibName: "TypeOne_CollectionViewCell", bundle: nil)
            cell.self.TypeOne_Collection.register(TypeOne_Nib, forCellWithReuseIdentifier: "TypeOne_Nib")
            cell.TypeOne_Collection.reloadData()
            return cell
        }
        
           
            
            
            //*******************  EXPLORE CELL ****************

        else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypeTwo_TableCell") as! TypeTwo_TableCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            // TAGGING COLLECTION-VIEW
            cell.TypeTwo_Collection.tag = indexPath.row
            
            
            // CONFIGURE CELL
            cell.TypeTwo_Collection.delegate = self
            cell.TypeTwo_Collection.dataSource = self
            let TypeTwo_Nib = UINib(nibName: "TypeTwo_CollectionViewCell", bundle: nil)
            cell.TypeTwo_Collection.register(TypeTwo_Nib, forCellWithReuseIdentifier: "TypeTwo_Nib")
            cell.TypeTwo_Collection.reloadData()
            
            return cell
        }
            
          
            
            
            //*******************  HOSTING CELL ****************

       
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypeThree_TableCell") as! TypeThree_TableCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
           
            // TAGGING COLLECTION-VIEW
            cell.TypeThree_Collection.tag = indexPath.row
            cell.TypeThree_Button.isHidden = true

            let hostValueArray = Array(HostingData.values)
            let name = Array(HostingData.keys)[indexPath.row - 2]
            
            
            
            // ADD TITLE TO LABEL
            let keyValue = Array(HostingData.keys)
            cell.TypeThree_Title.text = "Events in : \(keyValue[indexPath.row-2])"
          
            // CONFIGURE CELL
            
            if (HostingData[name]?.count)! < 3{
                cell.TypeThree_Button.isHidden = true
            }
            else{
                cell.TypeThree_Button.isHidden = false

            }
            cell.TypeThree_Collection.delegate=self
            cell.TypeThree_Collection.dataSource=self
            let TypeThree_Nib = UINib(nibName: "TypeThree_CollectionViewCell", bundle: nil)
            cell.TypeThree_Collection.register(TypeThree_Nib, forCellWithReuseIdentifier: "TypeThree_Nib")
            
            //
            cell.TypeThree_Button.tag = indexPath.row - 2
            
//
            
            let moreAdTap = UITapGestureRecognizer(target: self, action: #selector(moreAdAction))
            moreAdTap.name = name
            cell.TypeThree_Button.addGestureRecognizer(moreAdTap)
            //
            

            cell.TypeThree_Collection.reloadData()
            
            
            
            return cell
        }
      
     
    }
    
    @objc func moreAdAction(reg : UIGestureRecognizer){
        
       let recog = reg.name
        print(recog)
        
          self.performSegue(withIdentifier: "Suggested_Collection_Segue", sender: recog!)
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let cell = tableView.dequeueReusableCell(withIdentifier: "TypeThree_TableCell") as! TypeThree_TableCell
        
        print("tapp")
    }
    
    //************************* TABLE HEIGHT SETTING *****************
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        
        if indexPath.row == 0{
            return 240
            
            
        }
        else if indexPath.row == 1 {
            
           return 375
        }
        
        else
        {
        let hostValueArray = Array(HostingData)
        
        let totalValue =  hostValueArray[indexPath.row - 2].value.count
        
         if totalValue <= 2{
            return 275

        }
        return 575
    }
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

        
        if collectionView.tag == 0{
            
//            return 10
            return self.ExploreData.count
        }
            
        else if collectionView.tag == 1{
//            return 3
            return self.SuggestedData.count
        }
        
        let hostValueArray = Array(HostingData.values)[collectionView.tag - 2]
        return hostValueArray.count
        
    }
    
    
    
    // ***************** COLLECTION VIEW CELL FOR ITEM ****************************

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        
        
        if collectionView.tag == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypeOne_Nib", for: indexPath) as! TypeOne_CollectionViewCell
            
            cell.TypeOne_Label.text = self.ExploreData[indexPath.row]["Value"]
            
            let imageString =  self.ExploreData[indexPath.row]["Image"]
            let imageUrl = URL(string: imageString!)
            
            cell.TypeOne_Image.sd_setImage(with: imageUrl!, placeholderImage: UIImage(named: "thumbnail"), options: .progressiveDownload, completed: nil)
            
            return cell
        }
           
            
            
            
        else if collectionView.tag == 1{
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypeTwo_Nib", for: indexPath) as! TypeTwo_CollectionViewCell
            
            cell.TypeTwo_Caption.text = self.SuggestedData[indexPath.row]["Value"]
            
            let imageString =  self.SuggestedData[indexPath.row]["Image"]
            let imageUrl = URL(string: imageString!)
            
            cell.TypeTwo_Image.sd_setImage(with: imageUrl!, placeholderImage: UIImage(named: "thumbnail"), options: .progressiveDownload, completed: nil)
            return  cell
        }
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypeThree_Nib", for: indexPath) as! TypeThree_CollectionViewCell

        let hostValueArray = Array(HostingData.values)
        let name = Array(HostingData.keys)[collectionView.tag-2]
 
        
        cell.TypeThree_AD_Title.text = HostingData[name]![indexPath.row].AD_Title
        cell.TypeThree_Rent.text = "$\(hostValueArray[collectionView.tag - 2][indexPath.row].Rent)"
        cell.starRating.rating = Double( HostingData[name]![indexPath.row].Rating)!
        
//
        
       let imageString = hostValueArray[collectionView.tag - 2][indexPath.row].ImageUrl
        let singleImage =  imageString.split(separator: ",")
        
        let ImageURL = URL(string: String(singleImage[0]))
//
//
        cell.TypeThree_Image.sd_setImage(with: ImageURL, placeholderImage: UIImage(named: "thumbnail"), options: .progressiveDownload, completed: nil)
        
        
        
        return cell
//
    
    }
    
    
    
    // ***************** COLLECTION VIEW SIZE ****************************
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        
        if collectionView.tag == 0{
            
            return CGSize(width: 150, height: 175)

        }
            
        else if collectionView.tag == 1{
            
            return CGSize(width: 350, height:300)

        }
        
        return CGSize(width:150, height: 230)

    }



    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
//        backgroundView.alpha = 0.4
        
        if collectionView.tag == 0{
 
            
            print(collectionView.tag)
            
           let countryName =  (self.ExploreData[indexPath.row]["Value"])!
            
//            print(countryName)
            
            print("Collection View: Explore collection")
            
            self.performSegue(withIdentifier: "Explore_Collection_Segue", sender: countryName)

        }
       
        
        
        else if collectionView.tag == 1 {
         
            print(collectionView.tag)
            
            
            let cityName =  (self.SuggestedData[indexPath.row]["Value"])!

            
//            print(cityName)
            
            
            print("Collection View: Suggested collection")
            self.performSegue(withIdentifier: "Suggested_Collection_Segue", sender: cityName)


        }
        
      
        
        
        else{
            

            
        let hostValueArray = Array(HostingData.values)
        let name = Array(HostingData.keys)[collectionView.tag-2]
        
        
       
         let AD_Title  = HostingData[name]![indexPath.row].AD_Title
        let imageString = HostingData[name]![indexPath.row].ImageUrl
            
            
        let dataDictionary = ["AdValue" : AD_Title , "ImageValue" : imageString]
        
            
            print(dataDictionary)
            
        
            self.performSegue(withIdentifier: "detail", sender: dataDictionary)

        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Explore_Collection_Segue"{
            let dest = segue.destination as! exploreCollectionVC
            
            dest.Country_Name = sender as! String
        }
        
        else if segue.identifier == "Suggested_Collection_Segue" {
            let dest = segue.destination as! SuggestedCollectionVC
            
            dest.City_Name = sender as! String
            
        }
        
        else if segue.identifier == "detail"{
          
        let dest  =  segue.destination as! PropertyTableVC
        
        dest.AD_Dictionary = sender as! Dictionary
//        dest.AD_Name = sender as! String
    }
    }

  
}
