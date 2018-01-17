//
//  MainVC.swift
//  UberClone
//
//  Created by Jonathan Go on 2018/01/08.
//  Copyright © 2018 Appdelight. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase

class MainVC: UIViewController {

    var manager: CLLocationManager?
    
    var regionRadius: CLLocationDistance = 1000
    
    let currentUserId = Auth.auth().currentUser?.uid
    
    var tableView = UITableView()
    
    var matchingItems = [MKMapItem]()
    
    var route: MKRoute!
    
    var selectedItemPlacemark: MKPlacemark? = nil

    let headerBG: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    let menuBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "menuSliderBtn").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(handleMenuBtn), for: .touchUpInside)
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
        btn.addTarget(self, action: #selector(handleCenterMapBtn), for: .touchUpInside)
        return btn
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        manager = CLLocationManager()
        manager?.delegate = self
        manager?.desiredAccuracy = kCLLocationAccuracyBest

        mapView.delegate = self
        destTextField.delegate = self
        
        checkLocationAuthStatus()
        
        centerMapOnUserLocation()
        
        DataService.instance.REF_DRIVERS.observe(.value) { (snapshot) in
            self.loadDriverAnnotationsFromDB()
        }
        //loadDrivers()
        
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
    
    fileprivate func checkLocationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            manager?.startUpdatingLocation()
        } else {
            manager?.requestWhenInUseAuthorization()
        }
    }
    
//    func loadDrivers() {
//        DataService.instance.REF_DRIVERS.observe(.value) { (snapshot) in
//            guard let driverSnapshot = snapshot.children.allObjects as? [DataSnapshot] else { return }
//            for driver in driverSnapshot {
//                //if driver.hasChild("coordinate") {
//                    if driver.childSnapshot(forPath: "isPickUpModeEnabled").value as? Bool == true {
//                        if let driverDict = driver.value as? [String: Any] {
//                            let coordinateArray = driverDict["coordinate"] as! NSArray
//                            let driverCoordinate = CLLocationCoordinate2D(latitude: coordinateArray[0] as! CLLocationDegrees, longitude: coordinateArray[1] as! CLLocationDegrees)
//
//                            let annotation = DriverAnnotation(coordinate: driverCoordinate, withKey: driver.key)
//
//                            var driverIsVisible: Bool {
//                                return self.mapView.annotations.contains(where: { (annotation) -> Bool in
//                                    if let driverAnnotation = annotation as? DriverAnnotation {
//                                        if driverAnnotation.key == driver.key {
//                                            driverAnnotation.update(annotaionPosition: driverAnnotation, withCoordinate: driverCoordinate)
//                                            return true
//                                        }
//                                    }
//                                    return false
//                                })
//                            }
//                            if !driverIsVisible {
//                                self.mapView.addAnnotation(annotation)
//                            }
//                        }
////                    } else {
////                        for annotation in self.mapView.annotations {
////                            if annotation.isKind(of: DriverAnnotation.self) {
////                                if let annotation = annotation as? DriverAnnotation {
////                                    if annotation.key == driver.key {
////                                        self.mapView.removeAnnotation(annotation)
////                                    }
////                                }
////                            }
////                        }
//                    }
//               // }
//            }
//
//        }
//    }
    
    fileprivate func loadDriverAnnotationsFromDB() {
        DataService.instance.REF_DRIVERS.observeSingleEvent(of: .value) { (snapshot) in
            if let driverSnapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for driver in driverSnapshot {
                    if driver.hasChild("userIsDriver") {
                        if driver.hasChild("coordinate") {
                            if driver.childSnapshot(forPath: "isPickUpModeEnabled").value as? Bool == true {
                                if let driverDict = driver.value as? Dictionary<String, AnyObject> {
                                    let coordinateArray = driverDict["coordinate"] as! NSArray
                                    let driverCoordinate = CLLocationCoordinate2D(latitude: coordinateArray[0] as! CLLocationDegrees, longitude: coordinateArray[1] as! CLLocationDegrees)

                                    let annotation = DriverAnnotation(coordinate: driverCoordinate, withKey: driver.key)


                                    var driverIsVisible: Bool {
                                        return self.mapView.annotations.contains(where: { (annotation) -> Bool in
                                            if let driverAnnotation = annotation as? DriverAnnotation {
                                                if driverAnnotation.key == driver.key {
                                                    driverAnnotation.update(annotaionPosition: driverAnnotation, withCoordinate: driverCoordinate)
                                                    return true
                                                }
                                            }
                                            return false
                                        })
                                    }
                                    if !driverIsVisible {
                                        self.mapView.addAnnotation(annotation)
                                    }
                                }
                            } else {
                                for annotation in self.mapView.annotations {
                                    if annotation.isKind(of: DriverAnnotation.self) {
                                        if let annotation = annotation as? DriverAnnotation {
                                            if annotation.key == driver.key {
                                                self.mapView.removeAnnotation(annotation)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    fileprivate func centerMapOnUserLocation() {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
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

    @objc func handleMenuBtn() {
        let menuVC = MenuVC()
        navigationController?.pushViewController(menuVC, animated: true)
    }
    
    @objc func handleCenterMapBtn() {
        centerMapOnUserLocation()
        centerbtn.fadeTo(alphaValue: 0.0, withDuration: 0.2)
    }
    
}

extension MainVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        DataService.instance.REF_USERS.observeSingleEvent(of: .value) { (snapshot) in
            if let userSnapshot = snapshot.children.allObjects as? [DataSnapshot] {
            for user in userSnapshot {
                if user.key == self.currentUserId {
                    UpdateService.instance.updateUserLocation(withCoordinate: userLocation.coordinate, uid: self.currentUserId!)
                }
            }
            UpdateService.instance.updateDriverLocation(withCoordinate: userLocation.coordinate, uid: self.currentUserId!)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let lineRenderer = MKPolylineRenderer(overlay: self.route.polyline)
        lineRenderer.strokeColor = UIColor.logoOrange
        lineRenderer.lineWidth = 3
        lineRenderer.lineCap = .round
        
        return lineRenderer
    }
    
    func performSearch() {
        matchingItems.removeAll()
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = destTextField.text
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        
        search.start { (response, error) in
            if error != nil {
                print(error.debugDescription)
            } else if response!.mapItems.count == 0 {
                print("No results")
            } else {
                for mapItem in response!.mapItems {
                    self.matchingItems.append(mapItem as MKMapItem)
                    self.tableView.reloadData()
                }
            }
        }
    }

    func dropPinFor(placemark: MKPlacemark) {
        selectedItemPlacemark = placemark
        
        for annotation in mapView.annotations {
            if annotation.isKind(of: MKPointAnnotation.self) {
                mapView.removeAnnotation(annotation)
            }
        }
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        mapView.addAnnotation(annotation)
    }
    
    func searchMapKitForResultsWithPolyline(forMapItem mapItem: MKMapItem) {
        let request = MKDirectionsRequest()
        request.source = MKMapItem.forCurrentLocation()
        request.destination = mapItem
        request.transportType = MKDirectionsTransportType.automobile
        
        let directions = MKDirections(request: request)
        
        directions.calculate { (response, error) in
            guard let response = response else {
                print(error.debugDescription)
                return
            }
            self.route = response.routes[0]
            self.mapView.add(self.route.polyline)
        }
    }
    
}

extension MainVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? DriverAnnotation {
            let identifier = "driver"
            var view: MKAnnotationView
            view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.image = UIImage(named: "driverAnnotation")
            return view
        } else if let annotation  = annotation as? PassengerAnnotation {
            let identifier = "passenger"
            var view: MKAnnotationView
            view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.image = UIImage(named: "currentLocationAnnotation")
            return view
        } else if let annotation = annotation as? MKPointAnnotation {
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: DESTINATION)
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: DESTINATION)
            } else {
                annotationView?.annotation = annotation
            }
            annotationView?.image = UIImage(named: "destinationAnnotation")
            return annotationView
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        centerbtn.fadeTo(alphaValue: 1.0, withDuration: 0.2)
    }
}

extension MainVC: UITextFieldDelegate {
    //hides keybaord when user touches outside of keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //hides keyboard when return key is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == destTextField {
            performSearch()
            view.endEditing(true)
        }
        //textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == destTextField {
            tableView.frame = CGRect(x: 20, y: view.frame.height, width: view.frame.width - 40, height: view.frame.height - 190)
            tableView.layer.cornerRadius = 5.0
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: LOCATION_CELL)
        
            tableView.delegate = self
            tableView.dataSource = self
        
            tableView.tag = 18
            tableView.rowHeight = 60
        
            view.addSubview(tableView)
            animateTableView(shouldShow: true)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.destCircle.backgroundColor = .red
                self.destCircle.backgroundColor = UIColor.darkRed
            })
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == destTextField {
            if destTextField.text == "" {
                UIView.animate(withDuration: 0.3, animations: {
                    self.destCircle.backgroundColor = UIColor.myDestColor
                    self.destCircle.backgroundColor = UIColor.myDestBorderColor
                })
            }
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        matchingItems = []
        tableView.reloadData()
        animateTableView(shouldShow: false)
        centerMapOnUserLocation()
        return true
    }
    
    func animateTableView(shouldShow: Bool) {
        if shouldShow {
            UIView.animate(withDuration: 0.3, animations: {
                self.tableView.frame = CGRect(x: 20, y: 190, width: self.view.frame.width - 40, height: self.view.frame.height - 190)

            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.tableView.frame = CGRect(x: 20, y: self.view.frame.height, width: self.view.frame.width - 40, height: self.view.frame.height - 190)
            }, completion: { (finished) in
                for subview in self.view.subviews {
                    if subview.tag == 18 {
                        subview.removeFromSuperview()
                    }
                }
            })
        }
    }
    
}

extension MainVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: LOCATION_CELL)
        let mapItem = matchingItems[indexPath.row]
        cell.textLabel?.text = mapItem.name
        cell.detailTextLabel?.text = mapItem.placemark.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let passengerCoordinate = manager?.location?.coordinate
        
        let passengerAnnotation = PassengerAnnotation(coordinate: passengerCoordinate!, key: currentUserId!)
        mapView.addAnnotation(passengerAnnotation)
        
        destTextField.text = tableView.cellForRow(at: indexPath)?.textLabel?.text
        
        let selectedMapItem = matchingItems[indexPath.row]
        DataService.instance.REF_USERS.child(currentUserId!).updateChildValues(["tripCoordinate":[selectedMapItem.placemark.coordinate.latitude, selectedMapItem.placemark.coordinate.longitude]])
        
        dropPinFor(placemark: selectedMapItem.placemark)
        searchMapKitForResultsWithPolyline(forMapItem: selectedMapItem)
        
        animateTableView(shouldShow: false)
        print("row selected")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if destTextField.text == "" {
            animateTableView(shouldShow: false)
        }
    }
}
