//
//  DataService.swift
//  UberClone
//
//  Created by Jonathan Go on 2018/01/08.
//  Copyright © 2018 Appdelight. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    
    static let instance = DataService()
    
    private init() {}
    //public private(set) var DB_BASE = Database.database().reference()
    public private(set) var REF_BASE = DB_BASE
    public private(set) var REF_USERS = DB_BASE.child("users")
    public private(set) var REF_DRIVERS = DB_BASE.child("drivers")
    public private(set) var REF_TRIPS = DB_BASE.child("trips")
    //var REF_BASE = DB_BASE
    //var REF_USERS = DB_BASE.child("users")
    //var REF_DRIVERS = DB_BASE.child("drivers")
    //var REF_TRIPS = DB_BASE.child("trips")
    
//    init (REF_BASE: DatabaseReference, REF_USERS: DatabaseReference, REF_DRIVERS: DatabaseReference, REF_TRIPS: DatabaseReference) {
//        self.REF_BASE = REF_BASE
//        self.REF_USERS = REF_USERS
//        self.REF_DRIVERS = REF_DRIVERS
//        self.REF_TRIPS = REF_TRIPS
//    }
    
    func signupUser(email: String, password: String, segmentIndex: Int, imgFilename: String, uploadData: Data, vc: UIViewController, completion: @escaping CompletionHandler) {
        let isDriver = segmentIndex
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                let alert = Alert()
                if let errCode = AuthErrorCode(rawValue: (error._code)) {
                    
                    switch errCode {
                    case .invalidEmail:
                        print("Invalid email")
                        alert.displayAlertMessage(alertTitle: "Invalid Email", messageToDisplay: "Email syntax is not correct", vc: vc)
                    case .emailAlreadyInUse:
                        print("Email already in use")
                        alert.displayAlertMessage(alertTitle: "Email is taken", messageToDisplay: "This email is already in use", vc: vc)
                    case .weakPassword:
                        print("Password weak")
                        alert.displayAlertMessage(alertTitle: "Weak Password", messageToDisplay: "Password is too weak. Please choose a password which contains at least 6 characters.", vc: vc)
                    default:
                        // ALWAYS GET HERE.
                        print(error as Any)
                        alert.displayAlertMessage(alertTitle: "Error", messageToDisplay: "An unknown error occured.", vc: vc)
                    }
                    
                }
            } else {
                if let user = user {
                    Storage.storage().reference().child("profile_image").child("\(imgFilename).jpg").putData(uploadData, metadata: nil, completion: { (metadata, error) in
                        if let error = error {
                            print("Failed to upload profile image:", error)
                            return
                        }
                        guard let profileImageUrl = metadata?.downloadURL()?.absoluteString else { return }
                        print("Successfully uploaded profile image:", profileImageUrl)
                        
                    if isDriver == 0 {
                        let userData = ["provider": user.providerID, "userIsDriver": false, "profileImageUrl": profileImageUrl] as [String: Any]
                        self.REF_USERS.child(user.uid).updateChildValues(userData)
                    } else {
                        let userData = ["provider": user.providerID, "userIsDriver": true, "profileImageUrl": profileImageUrl, "isPickUpModeEnabled": false, "driverIsOnTrip": false] as [String: Any]
                        self.REF_DRIVERS.child(user.uid).updateChildValues(userData)
                    }
                    completion(true)
                })
                }
            }
        }
    }
}
