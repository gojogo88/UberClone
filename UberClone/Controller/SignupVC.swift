//
//  SignupVC.swift
//  UberClone
//
//  Created by Jonathan Go on 2018/01/08.
//  Copyright © 2018 Appdelight. All rights reserved.
//

import UIKit
import Firebase

class SignupVC: UIViewController {
    
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
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Medium", size: 15)
        label.text = "Sign up or Login to start requesting rides with HTCHHKR. The easiest way to get a lift anywhere."
        label.textColor = UIColor.logoBlack
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.tintColor = UIColor.lightGray
        button.addTarget(self, action: #selector(handlePlusPhoto), for: .touchUpInside)
        return button
    }()
    
    let segmentCtrl: UISegmentedControl = {
        let items = ["Passenger", "Driver"]
        let customSC = UISegmentedControl(items: items)
        customSC.selectedSegmentIndex = 0
        customSC.layer.cornerRadius = 5.0  // Don't let background bleed
        customSC.backgroundColor = UIColor.clear
        customSC.tintColor = UIColor.logoOrange
        return customSC
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
    
    let logintxt: UILabel = {
        let txt = UILabel()
        txt.text = "Already have an account? "
        txt.font = UIFont(name: "SF-Pro-Text-Medium", size: 17.0)
        txt.textColor = UIColor.logoBlack
        return txt
    }()
    
    let loginLinkBtn: UIButton = {
        let attributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17),
            NSAttributedStringKey.foregroundColor : UIColor.logoBlack,
            NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue]
        
        let attributeString = NSMutableAttributedString(string: "Login here", attributes: attributes)
        let btn = UIButton(type: .system)
        btn.setAttributedTitle(attributeString, for: .normal)
        
        return btn
    }()
    
    let signupButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("SIGN UP", for: .normal)
        btn.backgroundColor = UIColor.clear
        btn.setTitleColor(UIColor.btnTextColor, for: .normal)
        btn.titleLabel?.font = UIFont(name: "SFProDisplay-Black", size: 22.0)
        btn.layer.cornerRadius = 5
        btn.layer.shadowRadius = 10.0
        btn.layer.shadowColor = UIColor.shadowColor.cgColor
        btn.layer.shadowOpacity = 0.3
        btn.layer.shadowOffset = CGSize.zero
        btn.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(bgImg)
        bgImg.anchor(top: view.topAnchor, left: view.leadingAnchor, bottom: view.bottomAnchor, right: view.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(filter)
        filter.anchor(top: view.topAnchor, left: view.leadingAnchor, bottom: view.bottomAnchor, right: view.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(logoLabel)
        logoLabel.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 60, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(descLabel)
        descLabel.anchor(top: logoLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 300, height: 0)
        descLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        setupInputFields()
        emailField.delegate = self
        pswdField.delegate = self

//        view.addSubview(segmentCtrl)
//        segmentCtrl.anchor(top: descLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 330, height: 40)
//        segmentCtrl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//
//        view.addSubview(emailField)
//        emailField.anchor(top: segmentCtrl.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 330, height: 50)
//        emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        emailField.delegate = self
//
//        view.addSubview(pswdField)
//        pswdField.anchor(top: emailField.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 330, height: 50)
//        pswdField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        pswdField.delegate = self
        
        view.addSubview(signupButton)
        signupButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: 330, height: 60)
        signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        setupLogin()
    }
    
    fileprivate func setupInputFields() {
        segmentCtrl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        emailField.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        pswdField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [segmentCtrl, emailField, pswdField])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.alignment = .fill
        
        view .addSubview(plusPhotoButton)
        plusPhotoButton.anchor(top: descLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 120, height: 120)
        plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(stackView)
        stackView.anchor(top: plusPhotoButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 330, height: 0)
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    fileprivate func setupLogin() {
        let stackView = UIStackView(arrangedSubviews: [logintxt, loginLinkBtn])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        
        view.addSubview(stackView)
        stackView.anchor(top: nil, left: nil, bottom: signupButton.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 0)
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
//    func displayAlertMessage(alertTitle: String, messageToDisplay: String) {
//        let alertController = UIAlertController(title: alertTitle, message: messageToDisplay, preferredStyle: .alert)
//        
//        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
//            // Code in this block will trigger when OK button tapped.
//            print("Error transmitted")
//        }
//        alertController.addAction(OKAction)
//        self.present(alertController, animated: true, completion:nil)
//    }
    
    @objc func handleSignup() {
        guard let email = emailField.text else { return }
        guard let password = pswdField.text else { return }
        guard let image = self.plusPhotoButton.imageView?.image else { return }
        guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else { return }
        
        let imgFilename = UUID().uuidString.lowercased()   
        
        if email.isEmpty || password.isEmpty {
            let alert = Alert()
            alert.displayAlertMessage(alertTitle: "Empty Field(s)", messageToDisplay: "Please fill in all fields.", vc: self)
        } else {
            //signupButton.animateButton()
            self.view.endEditing(true)
            if segmentCtrl.selectedSegmentIndex == 0 {
                DataService.instance.signupUser(email: email, password: password, segmentIndex: 0, imgFilename: imgFilename, uploadData: uploadData, vc: self, completion: { (success) in
                    if success {
                        print("Passenger successfully added")
                        // stop animation, do segue
                    }
                })
            } else {
                DataService.instance.signupUser(email: email, password: password, segmentIndex: 1, imgFilename: imgFilename, uploadData: uploadData, vc: self, completion: { (success) in
                    if success {
                        print("Driver successfully added")
                        // stop animation, do segue
                    }
                })
            }
        }
    }
    
    @objc func handlePlusPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true)
    }
}

extension SignupVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            plusPhotoButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            plusPhotoButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.logoOrange.cgColor
        plusPhotoButton.layer.borderWidth = 2
        dismiss(animated: true, completion: nil)
    }
}

extension SignupVC: UITextFieldDelegate {
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
