//
//  MenuVC.swift
//  UberClone
//
//  Created by Jonathan Go on 2018/01/08.
//  Copyright © 2018 Appdelight. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {
    
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
        return btn
    }()
    
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
}
