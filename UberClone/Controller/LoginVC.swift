//
//  LoginVC.swift
//  UberClone
//
//  Created by Jonathan Go on 2018/01/08.
//  Copyright © 2018 Appdelight. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    let bgImg: UIImageView = {
        let bg = UIImageView()
        bg.image = UIImage(named: "windingRoad")
        return bg
    }()
    
    let filter: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        return blurredEffectView
    }()
    
    let logoLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "HTC", attributes: [NSAttributedStringKey.foregroundColor: UIColor.logoOrange, NSAttributedStringKey.font: UIFont(name: "SFProDisplay-Black", size: 48.0)!])
        attributedText.append(NSAttributedString(string: "HKR", attributes: [NSAttributedStringKey.foregroundColor: UIColor.logoBlack, NSAttributedStringKey.font: UIFont(name: "SFProDisplay-Black", size: 48.0)!]))
        label.attributedText = attributedText
        label.textAlignment = .center
        return label
    }()
    
    let loginTitle: UILabel = {
        let label = UILabel()
        label.text = "LOGIN"
        label.textColor = UIColor.logoBlack
        label.font = UIFont(name: "SF-Pro-Display-Bold", size: 25.0)
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    let emailField: UITextField = {
        let email = UITextField()
        email.setupTF(with: "Enter your email", keyboardType: .emailAddress, borderstyle: .roundedRect, isSecureText: false)
        return email
    }()
    
    let pswdField: UITextField = {
        let pswd = UITextField()
        pswd.setupTF(with: "Enter your password", keyboardType: .default, borderstyle: .roundedRect, isSecureText: true)
        return pswd
    }()
    
    let signuptxt: UILabel = {
        let txt = UILabel()
        txt.text = "Don't have an account yet? "
        txt.font = UIFont(name: "SF-Pro-Text-Medium", size: 17.0)
        txt.textColor = UIColor.logoBlack
        return txt
    }()
    
    let signupLinkBtn: UIButton = {
        let attributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17),
            NSAttributedStringKey.foregroundColor : UIColor.logoBlack,
            NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue]
        
        let attributeString = NSMutableAttributedString(string: "Sign up here", attributes: attributes)
        let btn = UIButton(type: .system)
        btn.setAttributedTitle(attributeString, for: .normal)
        
        return btn
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.white
        button.setTitle("LOGIN", for: .normal)
        button.setTitleColor(UIColor.btnTextColor, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Black", size: 22.0)
        button.layer.cornerRadius = 5
        button.layer.shadowRadius = 10.0
        button.layer.shadowColor = UIColor.shadowColor.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize.zero
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(bgImg)
        bgImg.anchor(top: view.topAnchor, left: view.leadingAnchor, bottom: view.bottomAnchor, right: view.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(filter)
        filter.anchor(top: view.topAnchor, left: view.leadingAnchor, bottom: view.bottomAnchor, right: view.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(logoLabel)
        logoLabel.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 100, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(loginTitle)
        loginTitle.anchor(top: logoLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        loginTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(emailField)
        emailField.anchor(top: loginTitle.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 330, height: 50)
        emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailField.delegate = self
        
        view.addSubview(pswdField)
        pswdField.anchor(top: emailField.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 330, height: 50)
        pswdField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pswdField.delegate = self
        
        view.addSubview(loginButton)
        loginButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: 330, height: 60)
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        setupSignup()
    }
    
    fileprivate func setupSignup() {
        let stackView = UIStackView(arrangedSubviews: [signuptxt, signupLinkBtn])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        
        view.addSubview(stackView)
        stackView.anchor(top: nil, left: nil, bottom: loginButton.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 0)
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc func handleLogin() {
        
    }
}

extension LoginVC: UITextFieldDelegate {
    //hides keybaord when user touches outside of keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //hides keyboard when return key is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
