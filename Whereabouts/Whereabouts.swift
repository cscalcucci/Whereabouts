//
//  Whereabouts.swift
//  Whereabouts
//
//  Created by Christopher Scalcucci on 9/14/15.
//  Copyright © 2015 Aphelion. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

public class Whereabouts: NSObject, CLLocationManagerDelegate {

    class var sharedInstance: Whereabouts {
        struct Static {
            static var onceToken: dispatch_once_t = 0

            static var instance: Whereabouts? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = Whereabouts()
        }
        return Static.instance!
    }

    private var locationManager = CLLocationManager()
    public var currentLocation : CLLocation!

    override init() {
        super.init()
        self.locationManager = CLLocationManager()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = 200
        self.locationManager.delegate = self
    }

    func startUpdatingLocation() {
        print("Starting Location Updates")
        self.locationManager.startUpdatingLocation()
    }

    func stopUpdatingLocation() {
        print("Stoping Location Updates")
        self.locationManager.stopUpdatingLocation()
    }

    public func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let location : CLLocation = locations.last!

        self.currentLocation = location

        CLGeocoder().reverseGeocodeLocation(self.currentLocation, completionHandler: {(placemarks, error) -> Void in

            print(self.currentLocation)

            if error != nil {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }

            if placemarks!.count > 0 {
                let pm : CLPlacemark = (placemarks?.first)!
                print(pm.locality)
            }
            else {
                print("Problem with the data received from geocoder")
            }
        })
    }

    func updateLocation(currentLocation:CLLocation){
        _ = currentLocation.coordinate.latitude
        _ = currentLocation.coordinate.longitude
    }
}

struct userLocation {

    var ID : NSNumber!
    var userID : NSNumber!
    var buildingTypeID : NSNumber!

    var firstName : String!
    var lastName : String!
    var phoneNumber : String!

    var address : Address!

    //???
    var active : Bool!
    var specialInstructions : String!
    var requireName : Bool!

}

struct Address {

    var latitude : NSNumber!
    var longitude : NSNumber!

    var street1 : String!
    var street2 : String!
    var city : String!
    var state : String!
    var zipcode : String!

    var buildingName : String!
    var crossStreet : String!

    var createdAt : NSDate!
    var updatedAt : NSDate!

}
