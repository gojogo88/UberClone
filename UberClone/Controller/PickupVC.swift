//
//  RequestVC.swift
//  UberClone
//
//  Created by Jonathan Go on 2018/01/21.
//  Copyright © 2018 Appdelight. All rights reserved.
//

import UIKit
import MapKit

class PickupVC: UIViewController {

    var regionRadius: CLLocationDistance = 2000
    var pin: MKPlacemark? = nil
    var pickupCoordinate: CLLocationCoordinate2D!
    var passengerKey: String!
    
    var locationPlacemark: MKPlacemark!
    
    let cancelButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "cancelBtn").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(handleCancelBtn), for: .touchUpInside)
        return btn
    }()
    
    let logoLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "HTC", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: "SFProDisplay-Black", size: 36.0)!])
        attributedText.append(NSAttributedString(string: "HKR", attributes: [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont(name: "SFProDisplay-Black", size: 36.0)!]))
        label.attributedText = attributedText
        label.textAlignment = .center
        return label
    }()
    
    let pickupMapView: MKMapView = {
        let map = MKMapView()
        map.mapType = MKMapType.standard
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        return map
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-DemiBold", size: 15)
        label.text = "Would you like to accept this passenger?"
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let acceptBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("ACCEPT TRIP", for: .normal)
        btn.setTitleColor(UIColor.requestBg, for: .normal)
        btn.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 22)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 5
        btn.layer.shadowRadius = 10.0
        btn.layer.shadowColor = UIColor.shadowColor.cgColor
        btn.layer.shadowOpacity = 0.3
        btn.layer.shadowOffset = CGSize.zero
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.requestBg
        navigationController?.isNavigationBarHidden = true
        pickupMapView.delegate = self
        
        view.addSubview(cancelButton)
        cancelButton.anchor(top: view.topAnchor, left: view.leadingAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        
        view.addSubview(logoLabel)
        logoLabel.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(pickupMapView)
        pickupMapView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 324, height: 324)
        pickupMapView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pickupMapView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        pickupMapView.layer.cornerRadius = 324/2
        pickupMapView.layer.borderColor = UIColor.white.cgColor
        pickupMapView.layer.borderWidth = 10
        
        locationPlacemark = MKPlacemark(coordinate: pickupCoordinate)
        dropPinfor(placemark: locationPlacemark)
        centerMapOnLocation(location: locationPlacemark.location!)
        
        view.addSubview(acceptBtn)
        acceptBtn.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: 330, height: 60)
        acceptBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(descLabel)
        descLabel.anchor(top: nil, left: nil, bottom: acceptBtn.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 15, paddingRight: 0, width: 0, height: 0)
        descLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func initData(coordinate: CLLocationCoordinate2D, passengerKey: String) {
        self.pickupCoordinate = coordinate
        self.passengerKey = passengerKey
    }
    
    @objc func handleCancelBtn() {
        dismiss(animated: true, completion: nil)
    }
}

extension PickupVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "pickupPoint"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(named: "destinationAnnotation")
        
        return annotationView
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        pickupMapView.setRegion(coordinateRegion, animated: true)
    }
    
    func dropPinfor(placemark: MKPlacemark) {
        pin = placemark
        
        for annotation in pickupMapView.annotations {
            pickupMapView.removeAnnotation(annotation)
        }
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        
        pickupMapView.addAnnotation(annotation)
    }
}
