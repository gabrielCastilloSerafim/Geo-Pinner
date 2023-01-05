//
//  MapProtocols.swift
//  Geo Pinner
//
//  Created by Gabriel Castillo Serafim on 30/12/22.
//  
//

import Foundation
import UIKit
import MapKit

protocol MapViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: MapPresenterProtocol? { get set }
    var myMapView: MKMapView { get }
    var scopeImage: UIImageView { get set }
    var changeMapSegmentedControlAnimator: UIViewPropertyAnimator { get set }
    
    func addAnotation(anotation: MKPointAnnotation)
    func animatePinImage(touchLocation: CGPoint)
    func updatePinImageLocation(with position: CGPoint)
    func animateNewPinButton()
    func animateCancelButton()
    func addImageSubview()
    func removeImageSubView()
    func setScopeImageToInitialState()
    func zoomIntoMapsInitialLocation(with mapCoordinates: MKCoordinateRegion)
    func addSegmentedControlSubView()
    func removeSegmenteControlSubview()
    func animateSegmenteControlIn()
    func animateSegmentedControlOut()
}

protocol MapWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createMapModule() -> UIViewController
    
    func goToCreateAnnotationView(fromVC: MapView, annotation: MKAnnotation, delegate: CreateAnnotationDelegate)
}

protocol MapPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: MapViewProtocol? { get set }
    var interactor: MapInteractorInputProtocol? { get set }
    var wireFrame: MapWireFrameProtocol? { get set }
    var isSegmentedControllPresented: Bool { get set }
    
    func viewDidLoad()
    func panRecognized(sender: UIPanGestureRecognizer)
    func addNewPinButtonTapped(buttonTitle: String?)
    func touchesBegan(touches: Set<UITouch>)
    func goToCurrentLocationTapped()
    func changeMapTypeTapped()
    func segmentedControllValueChanged(index: Int)
}

protocol MapInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
}

protocol MapInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: MapInteractorOutputProtocol? { get set }
    var localDatamanager: MapLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: MapRemoteDataManagerInputProtocol? { get set }
}

protocol MapDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol MapRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: MapRemoteDataManagerOutputProtocol? { get set }
}

protocol MapRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol MapLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}

protocol CreateAnnotationDelegate: AnyObject {
    // CREATEANNOTATIONVIEW -> MAPVIEW
    func didCreateAnnotation(annotation: MKPointAnnotation)
}
