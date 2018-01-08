//
//  GradientView.swift
//  UberClone
//
//  Created by Jonathan Go on 2018/01/08.
//  Copyright © 2018 Appdelight. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    let gradient = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupGradienView()
    }
    
    func setupGradienView() {
        gradient.frame = self.bounds  //set it as the same size as the view
        gradient.colors = [UIColor.white.cgColor, UIColor.init(white: 1.0, alpha: 0.0).cgColor]
        gradient.startPoint = CGPoint.zero  //starts at the top left
        gradient.endPoint = CGPoint(x: 0, y: 1)  // 1 for 100% vertical direction
        gradient.locations = [0.8, 1.0]  //starts at 80% of the view up to 100%
        
        self.layer.addSublayer(gradient)
        
    }
}

