//
//  MapWireFrame.swift
//  Geo Pinner
//
//  Created by Gabriel Castillo Serafim on 30/12/22.
//  
//

import Foundation
import UIKit

class MapWireFrame: MapWireFrameProtocol {
    
    class func createMapModule() -> UIViewController {
        
        let view = MapView()
        let navController =  UINavigationController()
        navController.viewControllers = [view]
        
        let presenter: MapPresenterProtocol & MapInteractorOutputProtocol = MapPresenter()
        let interactor: MapInteractorInputProtocol & MapRemoteDataManagerOutputProtocol = MapInteractor()
        let localDataManager: MapLocalDataManagerInputProtocol = MapLocalDataManager()
        let remoteDataManager: MapRemoteDataManagerInputProtocol = MapRemoteDataManager()
        let wireFrame: MapWireFrameProtocol = MapWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return navController
    }
    
    
    
}
