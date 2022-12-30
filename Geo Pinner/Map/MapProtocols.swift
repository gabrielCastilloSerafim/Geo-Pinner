//
//  MapProtocols.swift
//  Geo Pinner
//
//  Created by Gabriel Castillo Serafim on 30/12/22.
//  
//

import Foundation
import UIKit

protocol MapViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: MapPresenterProtocol? { get set }
}

protocol MapWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createMapModule() -> UIViewController
}

protocol MapPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: MapViewProtocol? { get set }
    var interactor: MapInteractorInputProtocol? { get set }
    var wireFrame: MapWireFrameProtocol? { get set }
    
    func viewDidLoad()
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
