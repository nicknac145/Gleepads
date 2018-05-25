//
//  PropertyTableVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 09/04/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//


import UIKit
import MapKit
import GoogleMaps
import CoreLocation
import Firebase
import SDWebImage

class PropertyTableVC: UITableViewController,ZGCarouselDelegate, UICollectionViewDelegate,UICollectionViewDataSource{
   
 
  
   
    

        var IMAGE = [UIImage]()
    
    // ****** OUTLET ***********
    
    
    
    @IBOutlet weak var propertyCategory: UILabel!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var profileImage: Custom_ImageView!
    @IBOutlet weak var minNight: UILabel!
    

    @IBOutlet var AmenitiesImages: [UIImageView]!
    @IBOutlet weak var moreAmenties: UILabel!
    
    @IBOutlet weak var MapView: UIView!
    @IBOutlet weak var CheckIn_Label: UILabel!
    @IBOutlet weak var CheckOut_Label: UILabel!
    
    @IBOutlet weak var reviewerImage: Custom_ImageView!
    @IBOutlet weak var reviewerName: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    
    @IBOutlet weak var scroll_image: ZGCarousel!
    @IBOutlet var propertyTable: UITableView!
    @IBOutlet weak var Similar_collection: UICollectionView!
    

    
    
    var bottomViewNib : PropertyBottomView!
    var final = UIApplication.shared.keyWindow
    var timer:Timer!
    var count = 0
    var propertyDetail : DiscoveryData?
    var AD_Name = ""
    var imageString = ""
    var AD_Dictionary = [String : String]()
    
    
    var similarProperty = [DiscoveryData]()
    
    var dbRef : DatabaseReference!
    var dbHandle : DatabaseHandle!
    
    // ******** VARIABLE FOR GEOLOCATION OPERATION **********
    let locationManager = CLLocationManager()
    var mapView = GMSMapView()
    var zoomLevel: Float = 15.0
    var currentLocation : CLLocation? = CLLocation(latitude: 0, longitude: 0)
    

    
   
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let tapButton = UITapGestureRecognizer(target: self, action: #selector(bookingAction))
        
      
        self.AD_Name = AD_Dictionary["AdValue"]!
        self.imageString = AD_Dictionary["ImageValue"]!
        
        let singleImage = self.imageString.split(separator: ",")
        
        print(singleImage.count)
        
        
        // *********** COLLECTING SCROLL VIEW IMAGES *************
        for loop in singleImage{
            
            
            let imageUrlString = loop
            
            
            let imageUrl = URL(string: String(imageUrlString))!
            
            let imageData = try! Data(contentsOf: imageUrl)
            
            let image = UIImage(data: imageData)
            
            self.IMAGE.append(image!)
        }
        
        
        moreAmenties.isHidden = true
        
        scroll_image.zgDelegate = self
        
        propertyTable.delegate = self
        propertyTable.dataSource = self
        
        Similar_collection.delegate = self
        Similar_collection.dataSource = self
//        Similar_collection.reloadData()
        
        self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.updateImage), userInfo: nil, repeats: true)
        
        
         self.bottomViewNib = Bundle.main.loadNibNamed("PropertyBottomView", owner: nil, options: nil)?.first as! PropertyBottomView
        
        
        self.bottomViewNib.frame.origin.y = self.view.frame.size.height - bottomViewNib.frame.size.height
        self.bottomViewNib.frame.size.width = self.view.frame.size.width
        UIApplication.shared.keyWindow?.addSubview(self.bottomViewNib)
        
        
        
        //  ***************** " Google Map " ********************
        
        
        // ***** LocationManager setting ******
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
            
        }
        else if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            
        }
        else if CLLocationManager.authorizationStatus() == .restricted {
            print(CLLocationManager.authorizationStatus())
        }

        
//        print(CLLocationManager.locationServicesEnabled())
        
        
//        print("****************")
//        print(AD_Name)
//        print("****************")

    
        dbRef = Database.database().reference()
        
        dbHandle = dbRef.child("Hosting").observe(.childAdded, with: { (valueSnapshot) in
            
            var AD = valueSnapshot.value as! [String:String]
            
            let name = AD["AD_Title"]!
            
            if name == self.AD_Name{
                let jsonData = try? JSONSerialization.data(withJSONObject: valueSnapshot.value as Any)
                self.propertyDetail = try? JSONDecoder().decode(DiscoveryData.self, from: jsonData!)
                
                
                
//                let bottonView = PropertyBottomView()
//                bottonView.rent.text = (self.propertyDetail?.Rent)!
                
                self.similarPropertyAD(city: (self.propertyDetail?.City)!, completion: { (similar) in
                   
                    if similar.AD_Title != self.AD_Name{
                    
                    self.similarProperty.append(similar)
                    
//                    print("&&&&&&&&&&&&&&&&&&&&&&&&&&")
//                    print((self.similarProperty))
//                    print("&&&&&&&&&&&&&&&&&&&&&&&&&&")
                    }
                })

//************* CONFIGURE SCROLL IMAGES *********
                
                let Images = (self.propertyDetail?.ImageUrl)!
                let imageArray = Images.split(separator: ",")
                
                
//                print("****************")
//                print(imageArray)
//                print("****************")
              
                
                
     // ******************* BottomNib INFORMATION **********************
                
                
                print((self.propertyDetail?.Rent)!)
                
                self.bottomViewNib.rent.text = "$ \((self.propertyDetail?.Rent)!) "
                
                
                self.bottomViewNib.StarRating.rating = Double((self.propertyDetail?.Rating)!)!
                
                self.bottomViewNib.bookingButton.addGestureRecognizer(tapButton)
                
                
                
                
    // ****************** Property Owner Profile image ********************
                
                let userID = (self.propertyDetail?.User_ID)!
                print(userID)
                
                self.dbRef.child("User_Profile").child(userID).observe(.value, with: { (profile) in
                    
                    let value = profile.value as! [String : String]
                    print(value["ProfileImage_Url"])
                    let imageString = (value["ProfileImage_Url"])!
                    let imageURL = URL(string: imageString)
                    self.profileImage.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "add_image"), options: .progressiveDownload, completed: nil)
                })
                
//************* CONFIGURE RESPECTIVE LABELS *********
                self.propertyCategory.text = ("Property Catergory: \((self.propertyDetail?.Property_Category)!)")
                self.TitleLabel.text = (self.propertyDetail?.AD_Title)!
                self.locationLabel.text = "Location :\((self.propertyDetail?.City)!)"
                self.DescriptionLabel.text = "Description: \((self.propertyDetail?.Description)!))"
                self.minNight.text = "\((self.propertyDetail?.Mininum_Day)!) night minimum"
                
                let amenitiesArray = (self.propertyDetail?.Amenities)!.split(separator: ",")
//                print(amenitiesArray)
                
                if amenitiesArray.count > 5{
                    
                    self.moreAmenties.isHidden = false
                }
                
                for loop in 0...(amenitiesArray.count - 1){
                    
                    self.AmenitiesImages[loop].image =  UIImage(named: String(amenitiesArray[loop]))
       
                }
                
                  self.CheckIn_Label.text = "Check-In \((self.propertyDetail?.Check_in)!)"
                self.CheckOut_Label.text = "Check-Out \((self.propertyDetail?.Check_out)!)"

                
                
                
// ********* CONFIGURE MAP ****************
                let lat = ((self.propertyDetail?.Latitude)! as NSString).doubleValue
                let long = ((self.propertyDetail?.Longitude)! as NSString).doubleValue
                let propertyCoordinate = CLLocation(latitude: lat, longitude: long)
          
                let camera = GMSCameraPosition.camera(withLatitude: propertyCoordinate.coordinate.latitude, longitude: propertyCoordinate.coordinate.longitude, zoom: self.zoomLevel)
                
                // ********** setting Mapview frame dimension ************
                
                self.mapView = GMSMapView.map(withFrame: self.MapView.bounds, camera: camera)
                
                self.mapView.animate(to: camera)
                
                self.MapView.addSubview(self.mapView)
                
                
                
// ******** Define user current location with Marker: *************
                
                let marker = GMSMarker(position: propertyCoordinate.coordinate)
                //                marker.icon = UIImage(named: "wifi")
                marker.iconView = UIImageView(image: UIImage(named: "marker"))
                //                marker.tracksViewChanges = true
                marker.title = "Gleepads Inc"
                marker.map = self.mapView

            }
            self.Similar_collection.reloadData()

        })

    }

    
    
    @objc func updateImage(){
        count+=1
        if count >= IMAGE.count{
            count = 0
        }
        scroll_image.moveTo(index: count)
        
    }
    
    
    
    func ZGitemData() -> [UIViewController] {
        
        
        var totalController = [UIViewController]()
        
        
        for totalImage in IMAGE{
            
            let cont = UIStoryboard(name: "Function", bundle: nil).instantiateViewController(withIdentifier: "image") as! ImageScrollVC
            cont.loadView()
            
            cont.displayImage.image = totalImage
            
            totalController.append(cont)
            
        }
        
        
        return totalController
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return testTitle.count
        return similarProperty.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Similar_Home", for: indexPath) as! Similar_CollectionCell
        
        cell.Home_Title.text = similarProperty[indexPath.row].AD_Title
        
        let imageString = similarProperty[indexPath.row].ImageUrl
        let imageArray = imageString.split(separator: ",")
        let displayImage = imageArray[0]
        let image_URL = URL(string: String(displayImage))
        
        cell.Home_Image.sd_setImage(with: image_URL, placeholderImage: UIImage(named: "thumbnail"), options: .progressiveDownload, completed: nil)
//        cell.Home_Title.text = testTitle[indexPath.row]
    
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedData = self.similarProperty[indexPath.row].AD_Title
        
        print(selectedData)
        
         let selectedImage = self.similarProperty[indexPath.row].ImageUrl
        
        print(selectedImage)
        
        self.AD_Name = self.similarProperty[indexPath.row].AD_Title
        self.imageString = self.similarProperty[indexPath.row].ImageUrl

        self.TitleLabel.text = selectedData
        
        //*****************************************************************
        
        self.CheckIn_Label.text = "Check-In \((self.similarProperty[indexPath.row].Check_in))"
        self.CheckOut_Label.text = "Check-Out \((self.similarProperty[indexPath.row].Check_out))"
        
        
        
        
        // ********* CONFIGURE MAP ****************
        let lat = ((self.similarProperty[indexPath.row].Latitude) as NSString).doubleValue
        let long = ((self.similarProperty[indexPath.row].Longitude) as NSString).doubleValue
        let propertyCoordinate = CLLocation(latitude: lat, longitude: long)
        
        let camera = GMSCameraPosition.camera(withLatitude: propertyCoordinate.coordinate.latitude, longitude: propertyCoordinate.coordinate.longitude, zoom: self.zoomLevel)
        
        // ********** setting Mapview frame dimension ************
        
        self.mapView = GMSMapView.map(withFrame: self.MapView.bounds, camera: camera)
        
        self.mapView.animate(to: camera)
        
        self.MapView.addSubview(self.mapView)
        
        
        
        // ******** Define user current location with Marker: *************
        
        let marker = GMSMarker(position: propertyCoordinate.coordinate)
        //                marker.icon = UIImage(named: "wifi")
        marker.iconView = UIImageView(image: UIImage(named: "marker"))
        //                marker.tracksViewChanges = true
        marker.title = "Gleepads Inc"
        marker.map = self.mapView
        
        
        //*****************************************************************
        
        
        // ******************* BottomNib INFORMATION **********************
        
        
        print((self.propertyDetail?.Rent)!)
        
        self.bottomViewNib.rent.text = "$ \((self.similarProperty[indexPath.row].Rent)) "
        
        
        self.bottomViewNib.StarRating.rating = Double((self.similarProperty[indexPath.row].Rating))!
        
//        self.IMAGE.removeAll()
//
//        self.imageString = self.similarProperty[indexPath.row].ImageUrl
//        let singleImage = self.imageString.split(separator: ",")
//
//        print(singleImage.count)
//
//
//        // *********** COLLECTING SCROLL VIEW IMAGES *************
//        for loop in singleImage{
//
//
//            let imageUrlString = loop
//
//
//            let imageUrl = URL(string: String(imageUrlString))!
//
//            let imageData = try! Data(contentsOf: imageUrl)
//
//            let image = UIImage(data: imageData)
//
//            self.IMAGE.append(image!)
//        }
//
    }
    
    @IBAction func dismiss_Action(_ sender: Any) {

        self.navigationController?.popViewController(animated: true)
        self.bottomViewNib.removeFromSuperview()
    }
    
    
    
    @IBAction func share_Action(_ sender: Any) {
        let shareActivity = UIActivityViewController(activityItems: ["www.gleepad.com"], applicationActivities: nil)
        
        shareActivity.popoverPresentationController?.sourceView = self.view
        self.present(shareActivity, animated: true, completion: nil)
        
        
    }
    
    func similarPropertyAD(city : String, completion : @escaping (DiscoveryData)->()){
        
        dbRef = Database.database().reference()
        
        dbHandle = dbRef.child("Hosting").observe(.childAdded, with: { (valueSnapshot) in
            
            var AD = valueSnapshot.value as! [String:String]
            
            let name = AD["AD_Title"]!

                let jsonData = try? JSONSerialization.data(withJSONObject: valueSnapshot.value as Any)
                let similar = try? JSONDecoder().decode(DiscoveryData.self, from: jsonData!)
            
            
            completion(similar!)
        })
    }
    
    
    @objc func bookingAction(){
    
   performSegue(withIdentifier: "Booking_Segue", sender: nil)
    }
    
}


    
extension PropertyTableVC: CLLocationManagerDelegate, GMSMapViewDelegate{
    
    
    
    
//
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
//        

    
    }
    
   
    }
    
    
    


    
  
