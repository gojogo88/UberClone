//
//  PassengerAnnotation.swift
//  UberClone
//
//  Created by Jonathan Go on 2018/01/13.
//  Copyright © 2018 Appdelight. All rights reserved.
//

import Foundation
import MapKit

class PassengerAnnotation: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    var key: String
    
    init(coordinate: CLLocationCoordinate2D, key: String) {
        self.coordinate = coordinate
        self.key = key
        super.init()
    }
}
