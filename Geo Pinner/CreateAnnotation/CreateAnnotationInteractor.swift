//
//  CreateAnnotationInteractor.swift
//  Geo Pinner
//
//  Created by Gabriel Castillo Serafim on 4/1/23.
//  
//

import Foundation

class CreateAnnotationInteractor: CreateAnnotationInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: CreateAnnotationInteractorOutputProtocol?
    var localDatamanager: CreateAnnotationLocalDataManagerInputProtocol?
    var remoteDatamanager: CreateAnnotationRemoteDataManagerInputProtocol?

}

extension CreateAnnotationInteractor: CreateAnnotationRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
