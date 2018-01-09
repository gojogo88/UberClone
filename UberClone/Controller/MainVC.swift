//
//  MainVC.swift
//  UberClone
//
//  Created by Jonathan Go on 2018/01/08.
//  Copyright © 2018 Appdelight. All rights reserved.
//

import UIKit
import MapKit

class MainVC: UIViewController {

    
    let headerBG: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    let menuBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "menuSliderBtn"), for: .normal)
        return btn
    }()
    
    let logoLabel: UILabel = {
        let lbl = UILabel()
        let attributedText = NSMutableAttributedString(string: "HTC", attributes: [NSAttributedStringKey.font: UIFont(name: "SFProDisplay-Heavy", size: 26)!, NSAttributedStringKey.foregroundColor: UIColor.logoOrange])
        attributedText.append(NSAttributedString(string: "HKR", attributes: [NSAttributedStringKey.font: UIFont(name: "SFProDisplay-Heavy", size: 26)!, NSAttributedStringKey.foregroundColor: UIColor.logoBlack]))
        lbl.attributedText = attributedText
        lbl.textAlignment = .center
        return lbl
    }()
    
    let proflePic: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "sample-photo")
        img.layer.cornerRadius = 30 / 2
        img.clipsToBounds = true
        return img
    }()
    
    
    let mapView: MKMapView = {
        let map = MKMapView()
        //mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
        map.mapType = MKMapType.standard
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        return map
    }()
    
    let inputContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.layer.shadowOpacity = 0.3
        view.layer.shadowColor = UIColor.shadowColor.cgColor
        view.layer.shadowRadius = 5
        view.layer.shadowOffset = CGSize(width: 5, height: 5)
        return view
    }()
    
    let locCircle: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.myLocColor
        view.layer.cornerRadius = 16 / 2
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.myLocBorderColor.cgColor
        view.clipsToBounds = true
        return view
    }()
    
    let destCircle: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.myDestColor
        view.layer.cornerRadius = 16 / 2
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.myDestBorderColor.cgColor
        view.clipsToBounds = true
        return view
    }()
    
    //lazy var myLocCircle: UIView = self.setupLocCircles(with: UIColor.myLocColor, borderColor: UIColor.myLocBorderColor.cgColor)
    
    let locTextField: UITextField = {
        let tf = UITextField()
        tf.setupTF(with: "My Location", keyboardType: .default, borderstyle: .none, isSecureText: false)
        return tf
    }()
    
    let destTextField: UITextField = {
        let tf = UITextField()
        tf.setupTF(with: "My Destination", keyboardType: .default, borderstyle: .none, isSecureText: false)
        return tf
    }()
    
    let dividingLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.btnTextColor
        return view
    }()
    
    
    
    let requestBtnContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    let requestBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("REQUEST RIDE", for: .normal)
        btn.setTitleColor(UIColor.btnTextColor, for: .normal)
        btn.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 22)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 5
        btn.layer.shadowRadius = 10.0
        btn.layer.shadowColor = UIColor.shadowColor.cgColor
        btn.layer.shadowOpacity = 0.3
        btn.layer.shadowOffset = CGSize.zero
        return btn
    }()
    
    let centerbtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "centerMapBtn").withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        mapView.delegate = self

        view.addSubview(headerBG)
        headerBG.anchor(top: view.topAnchor, left: view.leadingAnchor, bottom: nil, right: view.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 130)
    
        setupHeaderStack()
        
        view.addSubview(mapView)
        mapView.anchor(top: headerBG.bottomAnchor, left: view.leadingAnchor, bottom: view.bottomAnchor, right: view.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        mapView.center = view.center
        
        setupInput()
        setupRequestRide()
        
        view.addSubview(centerbtn)
        centerbtn.anchor(top: nil, left: nil, bottom: requestBtnContainer.topAnchor, right: requestBtn.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 8, paddingRight: 0, width: 60, height: 60)
        
        
        for family: String in UIFont.familyNames {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
        
    }
    
    fileprivate func setupHeaderStack() {
        menuBtn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        logoLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        proflePic.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [menuBtn, logoLabel, proflePic])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        
        headerBG.addSubview(stackView)
        stackView.anchor(top: nil, left: headerBG.leadingAnchor, bottom: nil, right: headerBG.trailingAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 30)
        stackView.centerYAnchor.constraint(equalTo: headerBG.centerYAnchor).isActive = true
    }
    
    fileprivate func setupInput() {
        view.addSubview(inputContainer)
        inputContainer.anchor(top: logoLabel.bottomAnchor, left: view.leadingAnchor, bottom: nil, right: view.trailingAnchor, paddingTop: 8, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 86)
    
        inputContainer.addSubview(locCircle)
        locCircle.anchor(top: inputContainer.topAnchor, left: inputContainer.leadingAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 16, height: 16)
        
        inputContainer.addSubview(locTextField)
        locTextField.anchor(top: nil, left: locCircle.trailingAnchor, bottom: nil, right: inputContainer.trailingAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 35)
        locTextField.centerYAnchor.constraint(equalTo: locCircle.centerYAnchor).isActive = true
        locTextField.delegate = self
        
        inputContainer.addSubview(dividingLine)
        dividingLine.anchor(top: locTextField.bottomAnchor, left: inputContainer.leadingAnchor, bottom: nil, right: inputContainer.trailingAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 1)
        
        inputContainer.addSubview(destCircle)
        destCircle.anchor(top: dividingLine.bottomAnchor, left: inputContainer.leadingAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 16, height: 16)
        
        inputContainer.addSubview(destTextField)
        destTextField.anchor(top: nil, left: destCircle.trailingAnchor, bottom: nil, right: inputContainer.trailingAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 35)
        destTextField.centerYAnchor.constraint(equalTo: destCircle.centerYAnchor).isActive = true
        destTextField.delegate = self
        
    }
    
    fileprivate func setupRequestRide() {
        view.addSubview(requestBtnContainer)
        requestBtnContainer.anchor(top: nil, left: view.leadingAnchor, bottom: view.bottomAnchor, right: view.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 80)
        
        requestBtnContainer.addSubview(requestBtn)
        requestBtn.anchor(top: requestBtnContainer.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 336, height: 60)
        requestBtn.centerXAnchor.constraint(equalTo: requestBtnContainer.centerXAnchor).isActive = true
        
    }

//    fileprivate func setupLocCircles(with color: UIColor, borderColor: CGColor) -> UIView {
//        let view = UIView()
//        view.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
//        view.layer.borderWidth = 1.5
//        view.backgroundColor = color
//        view.layer.cornerRadius = view.frame.width / 2
//        view.layer.borderColor = borderColor
//        return view
//    }
    
}

extension MainVC: MKMapViewDelegate {
    
}

extension MainVC: UITextFieldDelegate {
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
