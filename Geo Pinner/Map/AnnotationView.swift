//
//  AnnotationView.swift
//  Geo Pinner
//
//  Created by Gabriel Castillo Serafim on 4/1/23.
//

import Foundation
import MapKit

class AnnotationView: MKMarkerAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        setupAnnotationView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let detailButton = UIButton(type: .detailDisclosure)
    
    func setupAnnotationView() {
        
        canShowCallout = true
        rightCalloutAccessoryView = detailButton
    }
    
}
