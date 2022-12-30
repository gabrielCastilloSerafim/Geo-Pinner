//
//  MapView.swift
//  Geo Pinner
//
//  Created by Gabriel Castillo Serafim on 30/12/22.
//  
//

import Foundation
import UIKit

class MapView: UIViewController {

    // MARK: Properties
    var presenter: MapPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension MapView: MapViewProtocol {
    // TODO: implement view output methods
}
