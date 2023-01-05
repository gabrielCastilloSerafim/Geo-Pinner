//
//  CreateAnnotationPresenter.swift
//  Geo Pinner
//
//  Created by Gabriel Castillo Serafim on 4/1/23.
//  
//

import UIKit
import MapKit

class CreateAnnotationPresenter  {
    
    // MARK: Properties
    weak var view: CreateAnnotationViewProtocol?
    var interactor: CreateAnnotationInteractorInputProtocol?
    var wireFrame: CreateAnnotationWireFrameProtocol?
    var annotation: MKAnnotation?
    var delegate: CreateAnnotationDelegate?
    
}

extension CreateAnnotationPresenter: CreateAnnotationPresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
        view?.setLatitudeAndLongitudeValues(annotation: annotation)
    }
    
    func textViewDidBeginEditing(currentTextColor: UIColor) {
        if currentTextColor == .placeholderText {
            view?.changeDescriptionText(newText: nil)
            let newColor = UIColor { textColor in
                switch textColor.userInterfaceStyle {
                case .dark:
                    return .white
                default:
                    return .black
                }
            }
            view?.changeDescriptionTextColor(color: newColor)
        }
    }
    
    func textViewEndBeginEditing(textFieldText: String?) {
        if textFieldText == "" || textFieldText == nil {
            view?.changeDescriptionTextColor(color: .placeholderText)
            view?.changeDescriptionText(newText: "Description:")
        }
    }
    
    func addAnnotationButtonTapped(title: String?, description: String?) {
        if title == "" || title == nil {
            view?.showNoTitleAlert()
            return
        }
        guard let incompleteAnnotation = annotation else { print("Found nil annotation"); return }
        let newAnnotation = MKPointAnnotation()
        newAnnotation.coordinate = incompleteAnnotation.coordinate
        newAnnotation.title = title
        
        if description == "Description:" || description == nil || description == "" {
            newAnnotation.subtitle = "No description."
            delegate?.didCreateAnnotation(annotation: newAnnotation)
            wireFrame?.dismissTheCurrentView(currentView: view as! CreateAnnotationView)
        } else {
            newAnnotation.subtitle = description
            delegate?.didCreateAnnotation(annotation: newAnnotation)
            wireFrame?.dismissTheCurrentView(currentView: view as! CreateAnnotationView)
        }
        
        
    }
    
    
}

extension CreateAnnotationPresenter: CreateAnnotationInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
