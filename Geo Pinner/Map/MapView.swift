//
//  MapView.swift
//  Geo Pinner
//
//  Created by Gabriel Castillo Serafim on 30/12/22.
//  
//

import Foundation
import UIKit
import MapKit

class MapView: UIViewController {
    
    // MARK: Properties
    var presenter: MapPresenterProtocol?
    internal var myMapView = MKMapView()
    private let locationManager = CLLocationManager()
    internal var scopeImage = UIImageView()
    private let scopeImageAnimator = UIViewPropertyAnimator(duration: 0.05, curve: .easeOut)
    private let addButtonAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut)
    private let cancelButtonAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut)
    private let addPinButton = UIButton()
    private let goToCurrentLocationButton = UIButton()
    private let changeMapTypeButton = UIButton()
    internal var changeMapSegmentedControlAnimator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut)
    private let allPinsButton = UIButton()
    private let mapSegmentedControl = UISegmentedControl()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        presenter?.viewDidLoad()
    }
    
    private func setupView() {
        
        //view
        title = "My Pins"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(myMapView)
        view.addSubview(addPinButton)
        view.addSubview(goToCurrentLocationButton)
        view.addSubview(changeMapTypeButton)
        view.addSubview(allPinsButton)
        
        //pinImage
        scopeImage.image = UIImage(systemName: "scope")
        scopeImage.tintColor = .systemRed
        scopeImage.isUserInteractionEnabled = true
        scopeImage.contentMode = .scaleAspectFit
        scopeImage.frame = CGRect(x: (UIScreen.main.bounds.width/2)-25, y: (UIScreen.main.bounds.height/2)-25, width: 50, height: 50)
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panRecognized))
        scopeImage.addGestureRecognizer(panGestureRecognizer)
        
        //locationManager
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
        //myMapView
        myMapView.delegate = self
        myMapView.translatesAutoresizingMaskIntoConstraints = false
        myMapView.showsUserLocation = true
        myMapView.showsCompass = true
        myMapView.register(AnnotationView.self, forAnnotationViewWithReuseIdentifier: "AnnotationCustomViewID")
        
        NSLayoutConstraint.activate([
            myMapView.topAnchor.constraint(equalTo: view.topAnchor),
            myMapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myMapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            myMapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        //addPinButton
        addPinButton.setTitle("Add New Pin", for: .normal)
        addPinButton.backgroundColor = .black
        addPinButton.titleLabel?.textColor = .white
        addPinButton.layer.cornerRadius = 25
        addPinButton.layer.masksToBounds = true
        addPinButton.addTarget(self, action: #selector(addNewPinButtonTapped), for: .touchUpInside)
        addPinButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        addPinButton.frame = CGRect(x: UIScreen.main.bounds.minX+30,
                                    y: UIScreen.main.bounds.maxY-130,
                                    width: UIScreen.main.bounds.width-60,
                                    height: 52)
        
        //goToCurrentLocationButton
        goToCurrentLocationButton.setImage(UIImage(systemName: "location"), for: .normal)
        goToCurrentLocationButton.imageView?.tintColor = .black
        goToCurrentLocationButton.imageView?.contentMode = .scaleAspectFit
        goToCurrentLocationButton.backgroundColor = #colorLiteral(red: 0.9446026517, green: 0.9446026517, blue: 0.9446026517, alpha: 1)
        goToCurrentLocationButton.layer.cornerRadius = 10
        goToCurrentLocationButton.layer.masksToBounds = true
        goToCurrentLocationButton.translatesAutoresizingMaskIntoConstraints = false
        goToCurrentLocationButton.addTarget(self, action: #selector(goToCurrentLocationTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            goToCurrentLocationButton.heightAnchor.constraint(equalToConstant: 43),
            goToCurrentLocationButton.widthAnchor.constraint(equalToConstant: 43),
            goToCurrentLocationButton.bottomAnchor.constraint(equalTo: addPinButton.topAnchor, constant: -30),
            goToCurrentLocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        //changeMapTypeButton
        changeMapTypeButton.setImage(UIImage(systemName: "square.3.layers.3d.top.filled"), for: .normal)
        changeMapTypeButton.imageView?.tintColor = .black
        changeMapTypeButton.imageView?.contentMode = .scaleAspectFit
        changeMapTypeButton.backgroundColor = #colorLiteral(red: 0.9446026517, green: 0.9446026517, blue: 0.9446026517, alpha: 1)
        changeMapTypeButton.layer.cornerRadius = 10
        changeMapTypeButton.layer.masksToBounds = true
        changeMapTypeButton.translatesAutoresizingMaskIntoConstraints = false
        changeMapTypeButton.addTarget(self, action: #selector(changeMapTypeTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            changeMapTypeButton.heightAnchor.constraint(equalToConstant: 43),
            changeMapTypeButton.widthAnchor.constraint(equalToConstant: 43),
            changeMapTypeButton.bottomAnchor.constraint(equalTo: goToCurrentLocationButton.topAnchor, constant: -15),
            changeMapTypeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        //allPinsButton
        allPinsButton.setImage(UIImage(systemName: "mappin.and.ellipse"), for: .normal)
        allPinsButton.imageView?.tintColor = .black
        allPinsButton.imageView?.contentMode = .scaleAspectFit
        allPinsButton.backgroundColor = #colorLiteral(red: 0.9446026517, green: 0.9446026517, blue: 0.9446026517, alpha: 1)
        allPinsButton.layer.cornerRadius = 10
        allPinsButton.layer.masksToBounds = true
        allPinsButton.translatesAutoresizingMaskIntoConstraints = false
        allPinsButton.addTarget(self, action: #selector(allPinsTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            allPinsButton.heightAnchor.constraint(equalToConstant: 43),
            allPinsButton.widthAnchor.constraint(equalToConstant: 43),
            allPinsButton.bottomAnchor.constraint(equalTo: changeMapTypeButton.topAnchor, constant: -15),
            allPinsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        //mapSegmentedControl
        mapSegmentedControl.selectedSegmentTintColor = .black
        
        mapSegmentedControl.backgroundColor = .black
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        mapSegmentedControl.insertSegment(withTitle: "Standard", at: 0, animated: true)
        mapSegmentedControl.insertSegment(withTitle: "Satellite", at: 1, animated: true)
        mapSegmentedControl.insertSegment(withTitle: "Hybrid", at: 2, animated: true)
        mapSegmentedControl.selectedSegmentIndex = 0
        mapSegmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        
        
    }
    
    private func setScopeImageAnimation() {
        //Scope imageAnimation
        scopeImageAnimator.addAnimations {
            self.scopeImage.transform = CGAffineTransform(scaleX: 2, y: 2)
        }
    }
    
    private func setAddButtonAnimation() {
        //addButtonAnimation
        addButtonAnimator.addAnimations {
            self.addPinButton.frame.size.width -= (self.addPinButton.frame.size.width)/1.5
            self.addPinButton.frame.origin.x -= 15
            self.addPinButton.backgroundColor = .red
        }
        addButtonAnimator.addAnimations({
            self.addPinButton.setTitle("Cancel", for: .normal)
        }, delayFactor: 0.40)
    }
    
    private func setCancelButtonAnimation() {
        //cancelButtonAnimation
        cancelButtonAnimator.addAnimations {
            self.addPinButton.frame = CGRect(x: UIScreen.main.bounds.minX+30,
                                             y: UIScreen.main.bounds.maxY-130,
                                             width: UIScreen.main.bounds.width-60,
                                             height: 52)
            self.addPinButton.backgroundColor = .black
        }
        cancelButtonAnimator.addAnimations({
            self.addPinButton.setTitle("Add New Pin", for: .normal)
        }, delayFactor: 0.40)
    }
    
    private func setMapTypeSegmentedControlAnimationIn() {
        //segmentedControllAnimationIn
        changeMapSegmentedControlAnimator.addAnimations {
            self.mapSegmentedControl.frame = CGRect(x: (Int(UIScreen.main.bounds.maxX)/2)-110, y: Int(self.changeMapTypeButton.frame.minY), width: 220, height: 43)
        }
    }
    
    private func setMapTypeSegmentedControlAnimationOut() {
        //segmentedControllAnimationIn
        changeMapSegmentedControlAnimator.addAnimations {
            self.mapSegmentedControl.frame = CGRect(x: -220, y: Int(self.changeMapTypeButton.frame.minY), width: 220, height: 43)
        }
    }
    
    @objc func segmentedControlValueChanged() {
        presenter?.segmentedControllValueChanged(index: mapSegmentedControl.selectedSegmentIndex)
    }
    
    @objc func allPinsTapped() {
        
    }
    
    @objc func changeMapTypeTapped() {
        presenter?.changeMapTypeTapped()
    }
    
    @objc func goToCurrentLocationTapped() {
        presenter?.goToCurrentLocationTapped()
    }
    
    @objc func addNewPinButtonTapped() {
        presenter?.addNewPinButtonTapped(buttonTitle: addPinButton.titleLabel?.text)
    }
    
    @objc func panRecognized(sender: UIPanGestureRecognizer) {
        presenter?.panRecognized(sender: sender)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        presenter?.touchesBegan(touches: touches)
    }
    
    @objc func annotationDetailButtonPressed() {
        guard let selectedAnnotation = myMapView.selectedAnnotations.last else { print("Error getting selectedAnnotation"); return }
        print(selectedAnnotation.title)
    }
    
}

//MARK: - MKMapViewDelegate

extension MapView: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            let userLocationAnnotationView = MKUserLocationView(annotation: annotation, reuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
            return userLocationAnnotationView
        } else {
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationCustomViewID") as! AnnotationView
            annotationView.detailButton.addTarget(self, action: #selector(annotationDetailButtonPressed), for: .touchUpInside)
            return annotationView
        }
    }
    
    
    
    
}

extension MapView: MapViewProtocol {
    // TODO: implement view output methods
    
    func zoomIntoMapsInitialLocation(with mapCoordinates: MKCoordinateRegion) {
        myMapView.setRegion(mapCoordinates, animated: true)
    }
    
    func updatePinImageLocation(with position: CGPoint) {
        DispatchQueue.main.async {
            self.scopeImage.layer.position = CGPoint(x: position.x, y: position.y)
        }
    }
    
    func addAnotation(anotation: MKPointAnnotation) {
        DispatchQueue.main.async {
            self.myMapView.addAnnotation(anotation)
        }
    }
    
    func animatePinImage(touchLocation: CGPoint) {
        setScopeImageAnimation()
        DispatchQueue.main.async {
            self.scopeImageAnimator.startAnimation()
        }
    }
    
    func animateNewPinButton() {
        setAddButtonAnimation()
        DispatchQueue.main.async {
            self.addButtonAnimator.startAnimation()
        }
    }
    
    func animateCancelButton() {
        setCancelButtonAnimation()
        DispatchQueue.main.async {
            self.cancelButtonAnimator.startAnimation()
        }
    }
    
    func addImageSubview() {
        DispatchQueue.main.async {
            self.view.addSubview(self.scopeImage)
        }
    }
    
    func setScopeImageToInitialState() {
        //InitialState
        scopeImage.transform = CGAffineTransform(scaleX: 1, y: 1)
        scopeImage.frame = CGRect(x: (UIScreen.main.bounds.width/2)-25, y: (UIScreen.main.bounds.height/2)-25, width: 50, height: 50)
    }
    
    func removeImageSubView() {
        DispatchQueue.main.async {
            self.scopeImage.removeFromSuperview()
        }
    }
    
    func addSegmentedControlSubView() {
        mapSegmentedControl.frame = CGRect(x: -220, y: Int(self.changeMapTypeButton.frame.minY), width: 220, height: 43)
        DispatchQueue.main.async {
            self.view.addSubview(self.mapSegmentedControl)
        }
    }
    
    func animateSegmenteControlIn() {
        setMapTypeSegmentedControlAnimationIn()
        DispatchQueue.main.async {
            self.changeMapSegmentedControlAnimator.startAnimation()
        }
    }
    
    func animateSegmentedControlOut() {
        setMapTypeSegmentedControlAnimationOut()
        DispatchQueue.main.async {
            self.changeMapSegmentedControlAnimator.startAnimation()
        }
    }
    
    func removeSegmenteControlSubview() {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.mapSegmentedControl.removeFromSuperview()
        }
    }
    
    
    
}
