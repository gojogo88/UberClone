//
//  MenuVC.swift
//  UberClone
//
//  Created by Jonathan Go on 2018/01/08.
//  Copyright © 2018 Appdelight. All rights reserved.
//

import UIKit
import Firebase

class MenuVC: UIViewController {

    let currentUserId = Auth.auth().currentUser?.uid

    let headerBG: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        return view
    }()
    
    let menuTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "MENU"
        lbl.font = UIFont(name: "SFProDisplay-Bold", size: 24.0)
        lbl.textColor = .white
        return lbl
    }()
    
    let payments: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Payments", for: .normal)
        btn.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 24.0)
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        return btn
    }()
    
    let tips: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Tips", for: .normal)
        btn.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 24.0)
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        return btn
    }()
    
    let help: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Help", for: .normal)
        btn.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 24.0)
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        return btn
    }()
    
    let settings: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Settings", for: .normal)
        btn.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 24.0)
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        return btn
    }()
    
    let login: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Sign Up / Login", for: .normal)
        btn.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 24.0)
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        btn.addTarget(self, action: #selector(handleLoginLogout), for: .touchUpInside)
        return btn
    }()

    let pickupSwitch: UISwitch = {
        let pickup = UISwitch()
        pickup.addTarget(self, action: #selector(handleSwitchToggle), for: .touchUpInside)
        return pickup
    }()
    
    let pickupModeLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Pick up mode disabled"
        lbl.font = UIFont(name: "SFProText-Medium", size: 12.0)
        lbl.textColor = UIColor.btnTextColor
        return lbl
    }()

    let profilePic: CustomImageView = {
        let iv = CustomImageView()
        return iv
    }()
    
    let emailLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.font = UIFont(name: "SFProText-Regular", size: 16.0)
        lbl.textColor = UIColor.btnTextColor
        return lbl
    }()
    
    let acctTypeLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.font = UIFont(name: "SFProText-Bold", size: 14.0)
        lbl.textColor = UIColor.btnTextColor
        return lbl
    }()
    
    var user: User? {
        didSet {
            guard let profileImageUrl = user?.profileImageUrl else { return }
            profilePic.loadImage(urlString: profileImageUrl)
            acctTypeLabel.text = (user?.userIsDriver)! ? "Driver" : "Passenger"
            pickupModeLabel.text = (user?.isPickUpModeEnabled)! ? "PICK UP MODE ENABLED" : "PICK UP MODE DISABLED"
            
            //setupEditFollowButton()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(headerBG)
        headerBG.anchor(top: view.topAnchor, left: view.leadingAnchor, bottom: nil, right: view.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 90)
        
        headerBG.addSubview(menuTitle)
        menuTitle.anchor(top: nil, left: headerBG.leadingAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        menuTitle.centerYAnchor.constraint(equalTo: headerBG.centerYAnchor).isActive = true
        
        setupMenu()
        
        view.addSubview(login)
        login.anchor(top: nil, left: view.leadingAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 20, paddingRight: 0, width: 0, height: 0)
    
        setupAcctInfo()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        pickupSwitch.isOn = false
        pickupSwitch.isHidden = true
        pickupModeLabel.isHidden = true
        
        if currentUserId == nil {
            emailLabel.text = ""
            profilePic.isHidden = true
            acctTypeLabel.text = ""
        } else {
            login.setTitle("Log Out", for: .normal)
            DataService.instance.userProfile(uid: currentUserId!) { (user) in
                self.user = user
                
                self.emailLabel.text = Auth.auth().currentUser?.email
                self.profilePic.isHidden = false
                
                if self.acctTypeLabel.text == "Driver" {
                    self.pickupModeLabel.isHidden = false
                    self.pickupSwitch.isHidden = false
                    self.pickupSwitch.isOn = (user.isPickUpModeEnabled)!
                }
            }
            
        }
        
    }
    
    fileprivate func setupMenu() {
        let stack = UIStackView(arrangedSubviews: [payments, tips, help, settings])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 4
        stack.alignment = .leading
        
        view.addSubview(stack)
        stack.anchor(top: headerBG.bottomAnchor, left: view.leadingAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    fileprivate func setupAcctInfo() {
        view.addSubview(acctTypeLabel)
        acctTypeLabel.anchor(top: nil, left: view.leadingAnchor, bottom: login.topAnchor, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 30, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(emailLabel)
        emailLabel.anchor(top: nil, left: view.leadingAnchor, bottom: acctTypeLabel.topAnchor, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(profilePic)
        profilePic.anchor(top: nil, left: view.leadingAnchor, bottom: emailLabel.topAnchor, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 5, paddingRight: 0, width: 40, height: 40)
        profilePic.layer.cornerRadius = 40/2
        profilePic.layer.masksToBounds = true
        
        view.addSubview(pickupModeLabel)
        pickupModeLabel.anchor(top: nil, left: view.leadingAnchor, bottom: profilePic.topAnchor, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 15, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(pickupSwitch)
        pickupSwitch.anchor(top: nil, left: view.leadingAnchor, bottom: pickupModeLabel.topAnchor, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 4, paddingRight: 0, width: 0, height: 0)
    }
    
    @objc func handleLoginLogout() {
        if Auth.auth().currentUser == nil {
            //let signUpVC = SignupVC()
            navigationController?.popToRootViewController(animated: true)
        } else {
            do {
                try Auth.auth().signOut()
                pickupSwitch.isHidden = true
                pickupModeLabel.isHidden = true
                emailLabel.text = ""
                profilePic.isHidden = true
                acctTypeLabel.text = ""
                login.setTitle("Sign Up / Login", for: .normal)
                //let signUpVC = SignupVC()
                navigationController?.popToRootViewController(animated: true)
            } catch (let error) {
                print(error)
            }
        }
    }
    
    @objc func handleSwitchToggle() {
        if pickupSwitch.isOn {
            pickupModeLabel.text = "PICKUP MODE ENABLED"
            DataService.instance.REF_DRIVERS.child(currentUserId!).updateChildValues(["isPickUpModeEnabled" : true])
        } else {
            pickupModeLabel.text = "PICKUP MODE DISABLED"
            DataService.instance.REF_DRIVERS.child(currentUserId!).updateChildValues(["isPickUpModeEnabled" : false])
        }
    }
}
