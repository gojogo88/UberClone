//
//  RoundMapView.swift
//  UberClone
//
//  Created by Jonathan Go on 2018/01/21.
//  Copyright © 2018 Appdelight. All rights reserved.
//

import UIKit
import MapKit

class RoundMapView: MKMapView {

    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 10
    }
    

}
