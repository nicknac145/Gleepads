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

class PropertyTableVC: UITableViewController,ZGCarouselDelegate, UICollectionViewDelegate,UICollectionViewDataSource{
   
    
  
   
    
    var IMAGE = [#imageLiteral(resourceName: "dundee1"),#imageLiteral(resourceName: "dundee2"),#imageLiteral(resourceName: "dundee3"),#imageLiteral(resourceName: "dundee4")]

    
    // ****** OUTLET ***********
    
    
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
    
    var bottomViewNib : UIView!
    var final = UIApplication.shared.keyWindow
    var timer:Timer!
    var count = 0
    var AD_Name = ""
    
    // ******** VARIABLE FOR GEOLOCATION OPERATION **********
    let locationManager = CLLocationManager()
    var mapView = GMSMapView()
    var zoomLevel: Float = 15.0
    var currentLocation : CLLocation? = CLLocation(latitude: 0, longitude: 0)
    
    var dbRef : DatabaseReference!
    var dbHandle : DatabaseHandle!
    
    var propertyDetail : DiscoveryData?
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
 
        
        scroll_image.zgDelegate = self
        
        propertyTable.delegate = self
        propertyTable.dataSource = self
        
        Similar_collection.delegate = self
        Similar_collection.dataSource = self
        
        
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
        
        
        print("****************")
        print(AD_Name)
        print("****************")

    
        dbRef = Database.database().reference()
        
        dbHandle = dbRef.child("Hosting").observe(.childAdded, with: { (valueSnapshot) in
//            print (valueSnapshot.value)
            
            var AD = valueSnapshot.value as! [String:String]
            
            let name = AD["AD_Title"]!
            
            if name == self.AD_Name{
                let jsonData = try? JSONSerialization.data(withJSONObject: valueSnapshot.value)
                self.propertyDetail = try? JSONDecoder().decode(DiscoveryData.self, from: jsonData!)
                
//                print(discovery!)

                
                //************* CONFIGURE RESPECTIVE LABELS *********
                
                self.TitleLabel.text = (self.propertyDetail?.AD_Title)!
                self.locationLabel.text = (self.propertyDetail?.City)!
                self.DescriptionLabel.text = (self.propertyDetail?.Description)!
                self.minNight.text = "\((self.propertyDetail?.Mininum_Day)!) night minimum"
                
                let amenitiesArray = (self.propertyDetail?.Amenities)!.split(separator: ",")
                print(amenitiesArray)
                
                for loop in 0...(amenitiesArray.count - 1){
                    
                    self.AmenitiesImages[loop].image =  UIImage(named: String(amenitiesArray[loop]))
       
                }
                
                  self.CheckIn_Label.text = "Check-In\((self.propertyDetail?.Check_in)!)"
                self.CheckOut_Label.text = "Check-Out\((self.propertyDetail?.Check_out)!)"

                
                
                
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

        })
        
        
        
    
        
//        print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
//
//        print(propertyDetail?.Latitude)
//        print(propertyDetail?.Longitude)
//        print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$")


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Similar_Home", for: indexPath) as! Similar_CollectionCell
        
        return cell
        
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
    
}


    
extension PropertyTableVC: CLLocationManagerDelegate, GMSMapViewDelegate{
    
    
    
    
//
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
//        
//        
//        let location : CLLocation = locations.last!
//
//        self.currentLocation = location
//        locationManager.stopUpdatingHeading()
//
//
//        //        yourLocation["Latitude"] = String(location.coordinate.latitude)
//        //        yourLocation["Longitude"] = String(location.coordinate.longitude )
//
//
//
//        // ******** Define user current location with Marker: *************
//
//        let marker = GMSMarker(position: location.coordinate)
//        //                marker.icon = UIImage(named: "wifi")
//        marker.iconView = UIImageView(image: UIImage(named: "marker"))
//        //                marker.tracksViewChanges = true
//        marker.title = "Gleepads Inc"
//        marker.map = mapView
//
//
//        //
    
    }
    
   
    }
    
    
    


    
  
