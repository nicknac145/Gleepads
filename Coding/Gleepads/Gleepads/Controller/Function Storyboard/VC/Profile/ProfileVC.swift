//
//  ProfileVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 23/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import Firebase

class ProfileVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    //*********** STRUCT TO MANAGE DATA IN CELL WILL HOLD *************
    
    struct Cell_info {
        let cell : Int
        let image : UIImage?
        let Title : String?
        let Sub_Title  : String
    }
    
    // ********** VARIABLE ***********

    
    var vcNAme = [String]()

    @IBOutlet weak var profileTableView: UITableView!
    
    var dataArray = [Cell_info]()
   
    var dbRef =  Database.database().reference()
    let storage = Storage.storage()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(imageChange))
//
//        self.topTableView.imageCell.addGestureRecognizer(tap)
//
        

        
        
        
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
       
        
        // ********** DATA FOR TABLEVIEW CELL ***********

        dataArray = [Cell_info(cell: 1, image: #imageLiteral(resourceName: "tom.jpg"), Title: "Tom Cruise", Sub_Title: "view & edit"),
                     Cell_info(cell: 2, image: nil, Title: nil, Sub_Title: "Just 4 steps left"),
                     Cell_info(cell: 3, image: #imageLiteral(resourceName: "notify.png"), Title: nil, Sub_Title: "Notification"),
                     Cell_info(cell: 3, image: #imageLiteral(resourceName: "gift.png"), Title: nil, Sub_Title: "Invite friend"),
                     Cell_info(cell: 3, image: #imageLiteral(resourceName: "credit.png"), Title: nil, Sub_Title: "Credit & coupons"),
                     Cell_info(cell: 3, image: #imageLiteral(resourceName: "setting.png"), Title: nil, Sub_Title: "Setting"),
                     Cell_info(cell: 3, image: #imageLiteral(resourceName: "help.png"), Title: nil, Sub_Title: "Get Help"),
                     Cell_info(cell: 3, image: #imageLiteral(resourceName: "host.png"), Title: nil, Sub_Title: "Become a Host"),
                     Cell_info(cell: 3, image: #imageLiteral(resourceName: "Dashboard.png"), Title: nil, Sub_Title: " Host Dashboard"),
                     Cell_info(cell: 3, image: #imageLiteral(resourceName: "feedback.png"), Title: nil, Sub_Title: "Give us feedback"),
        ]
        
        
        // *********  NAME OF VIEW-CONTROLLER THAT WILL OPEN SELECTING TABLE CELL *************
        vcNAme = ["Notification",
                  "Invite",
                  "Credit",
                  "Setting",
                  "Help",
                  "Host",
                  "Host-Dashboard",
                  "Feedback"]
        
        profileTableView.delegate = self
        profileTableView.dataSource = self
        
        
     
    }
    
    
    
    
    
    // HANDLE NUMBER OF CELL
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    
    
    // HANDLE WHAT DATA TO BE SHOWN TO WHICH CELL.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if dataArray[indexPath.row].cell == 1{
            let cell = Bundle.main.loadNibNamed("TopTableViewCell", owner: self, options: nil)?.first as! TopTableViewCell
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none

            cell.TitleLabel.text = dataArray[indexPath.row].Title
            cell.subTitleLabel.text = dataArray[indexPath.row].Sub_Title
            cell.imageCell.image = dataArray[indexPath.row].image
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(imageChange))
            cell.imageCell.addGestureRecognizer(tap)
        
            
            return cell

        }
        else if dataArray[indexPath.row].cell == 2{
            
            let cell = Bundle.main.loadNibNamed("MiddleTableViewCell", owner: self, options: nil)?.first as! MiddleTableViewCell
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none

            cell.StepsLabel.text = dataArray[indexPath.row].Sub_Title
            return cell
        }
        else{
            let cell = Bundle.main.loadNibNamed("ButtonTableViewCell", owner: self, options: nil)?.first as! ButtonTableViewCell
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none

            cell.buttonImage.image = dataArray[indexPath.row].image
            cell.buttonTitle.text = dataArray[indexPath.row].Sub_Title
            return cell
        }

    }
    
    // SETTING HEIGHT OF RESPECTIVE CELL

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if dataArray[indexPath.row].cell == 1{
           return 108
            
        }
        else if dataArray[indexPath.row].cell == 2{
            return 150
            
        }
            
        else{
            return 75
        }
    }
    
    // ENABLE "SELECT CELL" FEATURE
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        if indexPath.row >= 2 {
            let VC = vcNAme[(indexPath.row)-2]
            let controller = storyboard?.instantiateViewController(withIdentifier: VC)
            self.navigationController?.pushViewController(controller!, animated: true)
        }
       
    }
    
    
    // ********** Change profile photo *******
    @objc func imageChange(){
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
    
        present(imagePicker, animated: true, completion: nil)
    
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        let selectedImage = info["UIImagePickerControllerOriginalImage"] as! UIImage
        
        var imageData = Data()
        
        imageData = UIImageJPEGRepresentation(selectedImage, 0.3)!
        
        
        
        let storageRef = self.storage.reference().child((Auth.auth().currentUser?.uid)!).child("User_Profile").child((Auth.auth().currentUser?.uid)!).child("profile_Image")
        
        let uploadMetaData = StorageMetadata()
        uploadMetaData.contentType = "image/jpeg"
        storageRef.putData(imageData, metadata: uploadMetaData, completion: { (metaData, error) in
            
            
            
            if error != nil{
                
                let alert = UIAlertController(title: "ERROR!", message: error?.localizedDescription, preferredStyle: .alert)
                
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                self.present(alert, animated: true, completion: nil)
                
                
            }
                
                
                
            else{
                
                print(metaData?.downloadURL()?.description)
                
            self.dbRef.child("User_Profile").child((Auth.auth().currentUser?.uid)!).child("ProfileImage_Url").setValue((metaData?.downloadURL()?.description)!)
                
                
            }
        })
        
        
        
        
        dismiss(animated: true, completion: nil)
        
    }
}
