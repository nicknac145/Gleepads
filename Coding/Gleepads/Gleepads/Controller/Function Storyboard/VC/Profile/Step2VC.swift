//
//  Step2VC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 28/04/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import SwiftVideoBackground
import MapKit
import GoogleMaps
import CoreLocation


class Step2VC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
  
    @IBOutlet weak var addImageLabel: UILabel!
    
    @IBOutlet weak var MapView: Custom_View!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    var propertyImageArray = [UIImage]()
   
    let locationManager = CLLocationManager()
    var currentLocation : CLLocation? = CLLocation(latitude: 0, longitude: 0)
    var mapView = GMSMapView()
    var zoomLevel: Float = 15.0
    
    var checkview : UIView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    
        try? VideoBackground.shared.play(view: view, videoName: "host", videoType: "mp4")
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        
        imageCollectionView.reloadData()
        
        imageCollectionView.isHidden = true
        
        
        // Google Map
        // *********************** LocationManager setting ***********************
      //  locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
//        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        
        print(CLLocationManager.locationServicesEnabled())
        
       
        
        
        
        // *********************** setting Map camera parameter ***********************

        let camera = GMSCameraPosition.camera(withLatitude: (self.currentLocation?.coordinate.latitude)!, longitude: (currentLocation?.coordinate.longitude)!, zoom: zoomLevel)
        
        // *********************** setting Mapview frame dimension ***********************
        mapView = GMSMapView.map(withFrame: MapView.bounds, camera: camera)
        
        
//        MapView = mapView
        MapView.addSubview(mapView)
        //        view.addSubview(mapView)
    }
    
    
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return propertyImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionCell
        
        cell.propertyImage.image = propertyImageArray[indexPath.row]
        
        
        return cell
        
    }
    
    @IBAction func addImage(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        
        present(imagePicker, animated: true) {
            self.addImageLabel.isHidden = true
            self.imageCollectionView.isHidden = false
        }
      

    }
    
  
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        let selectedImage = info["UIImagePickerControllerOriginalImage"] as! UIImage
        
        propertyImageArray.append(selectedImage)
        dismiss(animated: true, completion: nil)
        
        print(propertyImageArray)
        imageCollectionView.reloadData()
    }
    
    
    
}



extension Step2VC: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location : CLLocation = locations.last!
        
        print("loc=",location)
       
        
        
        // Setting Camera Position
        
     
            let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: zoomLevel)
            
            // *********************** Creating Map View ***********************
            mapView.animate(to: camera)
            

      
        
        
        // *********************** Define user current location with Marker: ***********************
        
        let marker = GMSMarker(position: location.coordinate)
//                marker.icon = UIImage(named: "wifi")
                marker.iconView = UIImageView(image: UIImage(named: "marker"))
                marker.tracksViewChanges = true
        marker.title = "Gleepads Inc"
        marker.map = mapView
        
        
//        // *********************** Retrieving "Near By Place" data  with Google Map API: ***********************
//        NearByPlace(Lat: String(location.coordinate.latitude), Long: String(location.coordinate.longitude), Radius: "1000", category: "shop", keyword: "mobile", completion: { (places) in
//
//
//            places.forEach({ (results) in
//
//                let name  = results["Title"] as! String
//                let lat  =  results["Latitude"] as! Double
//                let long  = results["Longitude"] as! Double
//
//                // TEST RESULT
//                print(lat,  long)
//
//
//
//                //***************** Markering  "Near By Place" location on MapView:***********************
//
//                let placeMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: lat, longitude: long))
//                placeMarker.icon = UIImage(named: "endPoint")
//                //        marker.iconView = UIImageView(image: UIImage(named: "signboardNode"))
//                //        marker.tracksViewChanges = true
//                placeMarker.title = name
//                placeMarker.map = self.mapView
//
//            })
//
//
//
//        })
        
        
    }
}
