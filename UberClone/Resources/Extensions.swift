//
//  Extensions.swift
//  UberClone
//
//  Created by Jonathan Go on 2018/01/08.
//  Copyright © 2018 Appdelight. All rights reserved.
//

import UIKit

extension UIColor {
    static let logoOrange = UIColor(named: "logoOrange")!
    static let logoBlack = UIColor(named: "closeToBlack")!
    static let shadowColor = UIColor(named: "shadowColor")!
    static let myLocColor = UIColor(named: "myLocColor")!
    static let myLocBorderColor = UIColor(named: "myLocBorderColor")!
    static let myDestColor = UIColor(named: "myDestColor")!
    static let myDestBorderColor = UIColor(named: "myDestBorderColor")!
    static let btnTextColor = UIColor(named: "btnTextColor")!
    static let darkRed = UIColor(named: "darkRed")!
}

extension UIViewController {
    func shouldPresentLoadingView(_ status: Bool) {
        var fadeView: UIView?
        
            fadeView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
            fadeView?.backgroundColor = .black
            fadeView?.alpha = 0.0
            fadeView?.tag = 99
            
            let spinner = UIActivityIndicatorView()
            spinner.color = .white
            spinner.activityIndicatorViewStyle = .whiteLarge
            spinner.center = view.center
            spinner.tag = 98
        
        if status == true {
            view.addSubview(fadeView!)
            view.addSubview(spinner)
            
            spinner.startAnimating()
            
            fadeView?.fadeTo(alphaValue: 0.7, withDuration: 0.2)
        } else {
            for subview in view.subviews {
                if subview.tag == 99  {
                    UIView.animate(withDuration: 0.3, animations: {
                        subview.alpha = 0.0
                    }, completion: { (finished) in
                        subview.removeFromSuperview()
                    })
                }
                if subview.tag == 98  {
                    UIView.animate(withDuration: 0.3, animations: {
                        subview.alpha = 0.0
                    }, completion: { (finished) in
                        subview.removeFromSuperview()
                    })
                }
            }
        }
    }
}

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat,  paddingLeft: CGFloat,  paddingBottom: CGFloat,  paddingRight: CGFloat, width: CGFloat = 0, height: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leadingAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            trailingAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func fadeTo(alphaValue: CGFloat, withDuration duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.alpha = alphaValue
        }
    }
}

extension UITextField {
    
    func setupTF(with placeholder: String, keyboardType: UIKeyboardType, borderstyle: UITextBorderStyle, isSecureText: Bool) {
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        isSecureTextEntry = isSecureText
        autocapitalizationType = .none
        autocorrectionType = UITextAutocorrectionType.no
        returnKeyType = UIReturnKeyType.done
        clearButtonMode = UITextFieldViewMode.whileEditing;
        backgroundColor = .white
        borderStyle = borderstyle
        font = UIFont(name: "SFProText-Bold", size: 16)
        let indentView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        leftView = indentView
        leftViewMode = .always
    }
}

extension UIButton {
    func animateButton() {
        let spinner = UIActivityIndicatorView()   //instantiate a spinner
        spinner.activityIndicatorViewStyle = .whiteLarge
        spinner.color = UIColor.btnTextColor
        spinner.alpha = 0.0
        spinner.hidesWhenStopped = true
        spinner.tag = 21
        
        isUserInteractionEnabled = false
        addSubview(spinner)
            
        setTitle("", for: .normal)
        UIView.animate(withDuration: 0.4, animations: {   //animate the button into a circle
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
    }
}

extension Date {
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let month = 4 * week
        
        let quotient: Int
        let unit: String
        if secondsAgo < minute {
            quotient = secondsAgo
            unit = "second"
        } else if secondsAgo < hour {
            quotient = secondsAgo / minute
            unit = "min"
        } else if secondsAgo < day {
            quotient = secondsAgo / hour
            unit = "hour"
        } else if secondsAgo < week {
            quotient = secondsAgo / day
            unit = "day"
        } else if secondsAgo < month {
            quotient = secondsAgo / week
            unit = "week"
        } else {
            quotient = secondsAgo / month
            unit = "month"
        }
        return "\(quotient) \(unit)\(quotient == 1 ? "" : "s") ago"
    }
}
