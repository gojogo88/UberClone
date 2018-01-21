//
//  Alertable.swift
//  UberClone
//
//  Created by Jonathan Go on 2018/01/18.
//  Copyright © 2018 Appdelight. All rights reserved.
//

import UIKit

protocol Alertable {}

extension Alertable where Self: UIViewController {
    func showAlert(_ alertTitle: String, msg: String) {
        let alertController = UIAlertController(title: alertTitle, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}
