//
//  CreateAnnotationWireFrame.swift
//  Geo Pinner
//
//  Created by Gabriel Castillo Serafim on 4/1/23.
//  
//

import Foundation
import UIKit
import MapKit

class CreateAnnotationWireFrame: CreateAnnotationWireFrameProtocol {
    
    class func createCreateAnnotationModule(annotation: MKAnnotation, delegate: CreateAnnotationDelegate) -> UIViewController {
        
        let view = CreateAnnotationView()
        
        let presenter: CreateAnnotationPresenterProtocol & CreateAnnotationInteractorOutputProtocol = CreateAnnotationPresenter()
        let interactor: CreateAnnotationInteractorInputProtocol & CreateAnnotationRemoteDataManagerOutputProtocol = CreateAnnotationInteractor()
        let localDataManager: CreateAnnotationLocalDataManagerInputProtocol = CreateAnnotationLocalDataManager()
        let remoteDataManager: CreateAnnotationRemoteDataManagerInputProtocol = CreateAnnotationRemoteDataManager()
        let wireFrame: CreateAnnotationWireFrameProtocol = CreateAnnotationWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.delegate = delegate
        presenter.interactor = interactor
        presenter.annotation = annotation
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return view
    }
    
    func dismissTheCurrentView(currentView: CreateAnnotationView) {
        currentView.dismiss(animated: true)
    }
    
}
