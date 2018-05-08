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


class Step2VC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UIImagePickerControllerDelegate,UINavigationControllerDelegate  {
  
    @IBOutlet weak var addImageLabel: UILabel!
    
    @IBOutlet weak var MapView: Custom_View!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    
   
    let locationManager = CLLocationManager()
    var mapView = GMSMapView()
    var zoomLevel: Float = 15.0
    
    var currentLocation : CLLocation?
    var propertyImageArray = [UIImage]()

    var hostDelegate : step2Delegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        mapView.delegate = self

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

        
        
        
        let camera  = GMSCameraPosition.camera(withLatitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!, zoom: zoomLevel)
//        let camera  = GMSCameraPosition.camera(withLatitude: (currentLocation?.coordinate.latitude)!, longitude: (currentLocation?.coordinate.longitude)!, zoom: zoomLevel)
        
        // *********************** setting Mapview frame dimension ***********************
        mapView = GMSMapView.map(withFrame: MapView.bounds, camera: camera)
        
        mapView.animate(to: camera)
        
        self.MapView.addSubview(mapView)
        
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
  
    @IBAction func ProceedButton(_ sender: Any) {
        
        
        let lat = currentLocation?.coordinate.latitude.description
        let long = currentLocation?.coordinate.longitude.description
        
        
    
        
        hostDelegate?.DataColletion(latitude: lat!,   Longitude: long!, PropertyImage:propertyImageArray)
        
        self.navigationController?.popViewController(animated: true)
        print("\(lat)  \(long)"  )
        print(propertyImageArray)
    }
}



extension Step2VC: CLLocationManagerDelegate, GMSMapViewDelegate{
    
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location : CLLocation = locations.last!
        
       self.currentLocation = location
        locationManager.stopUpdatingHeading()
        
        
//        yourLocation["Latitude"] = String(location.coordinate.latitude)
//        yourLocation["Longitude"] = String(location.coordinate.longitude )

        
      

        
        
        
      
        
        // *********************** Define user current location with Marker: ***********************
        
        let marker = GMSMarker(position: location.coordinate)
//                marker.icon = UIImage(named: "wifi")
                marker.iconView = UIImageView(image: UIImage(named: "marker"))
//                marker.tracksViewChanges = true
        marker.title = "Gleepads Inc"
        marker.map = mapView

        
//
        
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print(coordinate)
    }

    
    
    

    

}
