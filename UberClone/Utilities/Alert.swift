//
//  Alert.swift
//  UberClone
//
//  Created by Jonathan Go on 2018/01/09.
//  Copyright © 2018 Appdelight. All rights reserved.
//

import UIKit

class Alert {
    
    func displayAlertMessage(alertTitle: String, messageToDisplay: String, vc: UIViewController) {
        let alertController = UIAlertController(title: alertTitle, message: messageToDisplay, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            // Code in this block will trigger when OK button tapped.
            print("Error transmitted")
        }
        alertController.addAction(OKAction)
        vc.present(alertController, animated: true, completion:nil)
    }
    
//    class func showBasic(title: String, message: String, vc: UIViewController) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        vc.present(alert, animated: true)
//    }
}
