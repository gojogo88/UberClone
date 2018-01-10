//
//  User.swift
//  UberClone
//
//  Created by Jonathan Go on 2018/01/10.
//  Copyright © 2018 Appdelight. All rights reserved.
//

import Foundation

struct User {
    let uid: String
    let profileImageUrl: String
    let userIsDriver: Bool
    let isPickUpModeEnabled: Bool?
    let driverIsOnTrip: Bool?
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.userIsDriver = dictionary["userIsDriver"] as! Bool
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.isPickUpModeEnabled = dictionary["isPickUpModeEnabled"] as? Bool ?? false
        self.driverIsOnTrip = dictionary["driverIsOnTrip"] as? Bool ?? false
    }
}
