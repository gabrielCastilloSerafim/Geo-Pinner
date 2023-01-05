//
//  CreateAnnotationProtocols.swift
//  Geo Pinner
//
//  Created by Gabriel Castillo Serafim on 4/1/23.
//  
//

import Foundation
import UIKit
import MapKit

protocol CreateAnnotationViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: CreateAnnotationPresenterProtocol? { get set }
    
    func setLatitudeAndLongitudeValues(annotation: MKAnnotation?)
    func changeDescriptionText(newText: String?)
    func changeDescriptionTextColor(color: UIColor)
    func showNoTitleAlert()
}

protocol CreateAnnotationWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createCreateAnnotationModule(annotation: MKAnnotation, delegate: CreateAnnotationDelegate) -> UIViewController
    
    func dismissTheCurrentView(currentView: CreateAnnotationView)
}

protocol CreateAnnotationPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: CreateAnnotationViewProtocol? { get set }
    var interactor: CreateAnnotationInteractorInputProtocol? { get set }
    var wireFrame: CreateAnnotationWireFrameProtocol? { get set }
    var annotation: MKAnnotation? { get set }
    var delegate: CreateAnnotationDelegate? { get set }
    
    func viewDidLoad()
    func textViewDidBeginEditing(currentTextColor: UIColor)
    func textViewEndBeginEditing(textFieldText: String?)
    func addAnnotationButtonTapped(title: String?, description: String?)
}

protocol CreateAnnotationInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
}

protocol CreateAnnotationInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: CreateAnnotationInteractorOutputProtocol? { get set }
    var localDatamanager: CreateAnnotationLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: CreateAnnotationRemoteDataManagerInputProtocol? { get set }
}

protocol CreateAnnotationDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol CreateAnnotationRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: CreateAnnotationRemoteDataManagerOutputProtocol? { get set }
}

protocol CreateAnnotationRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol CreateAnnotationLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
