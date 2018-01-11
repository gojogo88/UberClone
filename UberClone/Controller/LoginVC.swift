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
    
    let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(" Sign up here.", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 15)
        button.setTitleColor(UIColor.logoOrange, for: .normal)
        button.addTarget(self, action: #selector(handleShowSignup), for: .touchUpInside)
        return button
    }()
    
    let signupLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.font = UIFont(name: "SFProText-Medium", size: 15)
        label.textColor = UIColor.lightGray
        label.textAlignment = .right
        return label
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
        navigationController?.isNavigationBarHidden = true
        
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
        
        setupSignupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    fileprivate func setupSignupView() {
        let stackView = UIStackView(arrangedSubviews: [signupLabel, signupButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        
        view.addSubview(stackView)
        stackView.anchor(top: nil, left: nil, bottom: loginButton.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        stackView.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor).isActive = true
    }
    
    @objc func handleLogin() {
        guard let email = emailField.text else { return }
        guard let password = pswdField.text else { return }
        
        if email.isEmpty || password.isEmpty {
            let alert = Alert()
            alert.displayAlertMessage(alertTitle: "Empty Field(s)", messageToDisplay: "Please fill in all fields.", vc: self)
        } else {
            //signupButton.animateButton()
            self.view.endEditing(true)
            DataService.instance.loginUser(email: email, password: password, vc: self, completion: { (success) in
                if success {
                    let mainVC = MainVC()
                    self.navigationController?.pushViewController(mainVC, animated: true)
                    //self.present(menuVC, animated: true, completion: nil)
                }
            })
        }
    }
    
    @objc func handleShowSignup() {
        navigationController?.popToRootViewController(animated: true)
        //dismiss(animated: true, completion: nil)
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
