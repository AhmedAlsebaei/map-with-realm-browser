//
//  ViewController.swift
//  map
//
//  Created by ahmed aelsebaay on 05/05/2021.
//

import UIKit
import GoogleMaps
import RealmSwift
import Realm
class ViewController: UIViewController , CLLocationManagerDelegate{

    
    var aesKeyBytes = [UInt8](repeating: 0, count: 32)
    
    
    
    var locationManager = CLLocationManager()
    var rlm = try! Realm()
    
    @IBOutlet weak var mapview: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: 29.9802194, longitude: 30.9547218, zoom: 15)
        self.mapview.camera = camera
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(-33.86, 151.20)
        marker.title = "6of october city"
        marker.snippet = "egypt"
        marker.map = self.mapview

        print(Realm.Configuration.defaultConfiguration.fileURL?.absoluteURL)

        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        let locations  = rlm.objects(locationstring.self)
        
        let aesKeyData = Data(aesKeyBytes)
          let aesKeyDict:[NSObject:NSObject] = [
               kSecAttrKeyType: kSecAttrKeyTypeRSA,
               kSecAttrKeyClass: kSecAttrKeyClassSymmetric,
               kSecAttrKeySizeInBits: NSNumber(value: 256),
               kSecReturnPersistentRef: true as NSObject
          ]
          let aesKey = SecKeyCreateWithData(aesKeyData as CFData, aesKeyDict as CFDictionary, nil)
    
        
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last

        let locationModel = locationstring ()
        //locationModel.location = location
        locationModel.country = "egypt"
        locationModel.marker = "6of october"
      
       try! rlm.write {
            rlm.add(locationModel)
            
            
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!  , longitude: (location?.coordinate.longitude)!, zoom: 15)
        
        self.mapview.camera = camera
        
        print("got a location \(locations)")
    }
    
    
}

