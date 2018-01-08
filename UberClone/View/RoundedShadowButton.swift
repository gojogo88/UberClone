//
//  RoundedShadowButton.swift
//  UberClone
//
//  Created by Jonathan Go on 2018/01/08.
//  Copyright © 2018 Appdelight. All rights reserved.
//

import UIKit

class RoundedShadowButton: UIButton {
    
    var originalSize: CGRect?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupButtonView()
    }
    
    func setupButtonView() {
        originalSize = self.frame   //to capture the original size of the button
        setTitle("REQUEST RIDE", for: .normal)
        setTitleColor(UIColor.btnTextColor, for: .normal)
        titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 22)
        backgroundColor = .white
        layer.cornerRadius = 5
        layer.shadowRadius = 10.0
        layer.shadowColor = UIColor.shadowColor.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize.zero
    }
    
    func animateButton(shouldLoad: Bool, withMessage message: String?) {
        let spinner = UIActivityIndicatorView()   //instantiate a spinner
        spinner.activityIndicatorViewStyle = .whiteLarge
        spinner.color = UIColor.btnTextColor
        spinner.alpha = 0.0
        spinner.hidesWhenStopped = true
        spinner.tag = 21
        
        if shouldLoad {
            self.addSubview(spinner)
            
            self.setTitle("", for: .normal)
            UIView.animate(withDuration: 0.2, animations: {   //animate the button into a circle
                self.layer.cornerRadius = self.frame.height / 2
                self.frame = CGRect(x: self.frame.midX - (self.frame.height / 2), y: self.frame.origin.y, width: self.frame.height, height: self.frame.height)
            }, completion: { (finished) in
                if finished == true {
                    spinner.startAnimating()
                    spinner.center = CGPoint(x: self.frame.width / 2 + 1, y: self.frame.width / 2 + 1)
                    
                    spinner.fadeTo(alphaValue: 1.0, withDuration: 0.2)
                    //UIView.animate(withDuration: 0.2, animations: {
                    //    spinner.alpha = 1.0
                    //})
                }
            })
            self.isUserInteractionEnabled = false
        } else {   //if loading is finished
            self.isUserInteractionEnabled = true
            
            for subview in self.subviews {
                if subview.tag == 21 {
                    subview.removeFromSuperview()
                }
            }
            UIView.animate(withDuration: 0.3, animations: {
                self.layer.cornerRadius = 5.0
                self.frame = self.originalSize!
                self.setTitle(message, for: .normal)
            })
        }
    }
    
}

