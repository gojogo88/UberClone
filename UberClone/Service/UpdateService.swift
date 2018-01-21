//
//  UpdateService.swift
//  UberClone
//
//  Created by Jonathan Go on 2018/01/11.
//  Copyright © 2018 Appdelight. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import Firebase

class UpdateService {
    static var instance = UpdateService()
    
    func updateUserLocation(withCoordinate coordinate: CLLocationCoordinate2D, uid: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let values = ["coordinate": [coordinate.latitude, coordinate.longitude]] as [String: Any]
        DataService.instance.REF_USERS.child(uid).updateChildValues(values)
    }
    
    func updateDriverLocation(withCoordinate coordinate: CLLocationCoordinate2D, uid: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
              let values = ["coordinate": [coordinate.latitude, coordinate.longitude]] as [String: Any]
        DataService.instance.REF_DRIVERS.child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let userDictionary = snapshot.value as? [String: Any] else { return }
            guard let isPickUpModeEnabled = userDictionary["isPickUpModeEnabled"] as? Bool else { return }
            if isPickUpModeEnabled == true {
                DataService.instance.REF_DRIVERS.child(uid).updateChildValues(values)
            }
        })
    }
    
    func observeTrips(handler: @escaping(_ coordinateDict: Dictionary<String, AnyObject>?) -> Void) {
        DataService.instance.REF_TRIPS.observe(.value) { (snapshot) in
            if let tripSnapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for trip in tripSnapshot {
                    if trip.hasChild("passengerKey") && trip.hasChild("tripIsAcceptred") {
                        if let tripDict = trip.value as? Dictionary<String, AnyObject> {
                            handler(tripDict)
                        }
                    }
                }
            }
        }
    }
    
    func updateTripsWithCoordinateUponRequest() {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        DataService.instance.REF_USERS.observeSingleEvent(of: .value) { (snapshot) in
            if let userSnapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for user in userSnapshot {
                    if user.key == uid {
                        if !user.hasChild("userIsDriver") {
                            if let userDict = user.value as? Dictionary<String, AnyObject> {
                                let pickupArray = userDict["coordinate"] as! NSArray
                                let destinationArray = userDict["tripCoordinate"] as! NSArray
                            
                                DataService.instance.REF_TRIPS.child(user.key).updateChildValues(["pickupCoordinate": [pickupArray[0], pickupArray[1]], "destinationCoordinate": [destinationArray[0], destinationArray[1]], "passengerKey": user.key, "tripIsAccepted": false])
                            }
                        }
                    }
                }
            }
        }
    }
}
