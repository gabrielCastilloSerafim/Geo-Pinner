//
//  MapPresenter.swift
//  Geo Pinner
//
//  Created by Gabriel Castillo Serafim on 30/12/22.
//  
//

import UIKit
import MapKit

class MapPresenter: CreateAnnotationDelegate  {
    
    // MARK: Properties
    weak var view: MapViewProtocol?
    var interactor: MapInteractorInputProtocol?
    var wireFrame: MapWireFrameProtocol?
    internal var isSegmentedControllPresented = false
    
    //This method gets called by the create annotation button from the craete annotation presenter
    func didCreateAnnotation(annotation: MKPointAnnotation) {
        view?.addAnotation(anotation: annotation)
    }
    
}

extension MapPresenter: MapPresenterProtocol {
    
    // TODO: implement presenter methods
    
    func viewDidLoad() {
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            let startLocation = CLLocation(latitude: (self.view?.myMapView.userLocation.coordinate.latitude)!,
                                           longitude: (self.view?.myMapView.userLocation.coordinate.longitude)!)
            let distanceSpan: CLLocationDistance = 500
            let mapCoordinates = MKCoordinateRegion(center: startLocation.coordinate, latitudinalMeters: distanceSpan, longitudinalMeters: distanceSpan)
            self.view?.zoomIntoMapsInitialLocation(with: mapCoordinates)
        }
        
        
    }
    
    func goToCurrentLocationTapped() {
        let userLocation = CLLocation(latitude: (self.view?.myMapView.userLocation.coordinate.latitude)!,
                                      longitude: (self.view?.myMapView.userLocation.coordinate.longitude)!)
        let distanceSpan: CLLocationDistance = 500
        let mapCoordinates = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: distanceSpan, longitudinalMeters: distanceSpan)
        self.view?.zoomIntoMapsInitialLocation(with: mapCoordinates)
    }
    
    func addNewPinButtonTapped(buttonTitle: String?) {
        guard let buttonTitle = buttonTitle else { return }
        
        if buttonTitle == "Add New Pin" {
            view?.animateNewPinButton()
            view?.addImageSubview()
        } else {
            view?.animateCancelButton()
            view?.removeImageSubView()
        }
    }
    
    func panRecognized(sender: UIPanGestureRecognizer) {
        let location = sender.location(in: view?.myMapView)
        
        view?.updatePinImageLocation(with: location)
        
        if sender.state == UIPanGestureRecognizer.State.ended {
            let coordinate = view?.myMapView.convert(location, toCoordinateFrom: view?.myMapView)
            guard let coordinate = coordinate else { print("Error converting coordinate"); return }
            let anotation = MKPointAnnotation()
            anotation.coordinate = coordinate
            
            view?.animateCancelButton()
            view?.setScopeImageToInitialState()
            view?.removeImageSubView()
            wireFrame?.goToCreateAnnotationView(fromVC: view as! MapView, annotation: anotation, delegate: self)
        }
    }
    
    func touchesBegan(touches: Set<UITouch>) {
        for touch in touches {
            if touch.view == view?.scopeImage {
                let touchLocation = touch.location(in: view?.myMapView)
                view?.animatePinImage(touchLocation: touchLocation)
            }
        }
    }
    
    func changeMapTypeTapped() {
        guard view?.changeMapSegmentedControlAnimator.isRunning == false else { return }
        
        if isSegmentedControllPresented == false {
            view?.addSegmentedControlSubView()
            view?.animateSegmenteControlIn()
        } else {
            view?.animateSegmentedControlOut()
            view?.removeSegmenteControlSubview()
        }
        isSegmentedControllPresented = !isSegmentedControllPresented
    }
    
    func segmentedControllValueChanged(index: Int) {
        
        switch index {
        case 0:
            view?.myMapView.mapType = .standard
        case 1:
            view?.myMapView.mapType = .satellite
        default:
            view?.myMapView.mapType = .hybrid
        }
    }
    
}

extension MapPresenter: MapInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
