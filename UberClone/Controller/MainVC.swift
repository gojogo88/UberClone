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
    
    lazy var myLocCircle: UIView = self.setupLocCircles(with: UIColor.myLocColor, borderColor: UIColor.myLocBorderColor.cgColor)
    
    
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

    fileprivate func setupLocCircles(with color: UIColor, borderColor: CGColor) -> UIView {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        view.layer.borderWidth = 1.5
        view.backgroundColor = color
        view.layer.cornerRadius = view.frame.width / 2
        view.layer.borderColor = borderColor
        return view
    }
    
    fileprivate func setupInputView() {
        myLocCircle.widthAnchor.constraint(equalToConstant: 16).isActive = true
        //myLocTextField.widthAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        
        //let stackView = UIStackView(arrangedSubviews: [myLocCircle, myLocTextField])
        //stackView.axis = .horizontal
        //stackView.distribution = .fill
        //stackView.spacing = 10
        //stackView.alignment = .fill
        
        //locInputView.addSubview(stackView)
        //stackView.anchor(top: locInputView.topAnchor, left: locInputView.leadingAnchor, bottom: nil, right: locInputView.trailingAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 25)
    }
}

extension MainVC: MKMapViewDelegate {
    
}
