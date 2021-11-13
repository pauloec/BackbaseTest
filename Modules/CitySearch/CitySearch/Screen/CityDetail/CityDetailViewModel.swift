//
//  CityDetailViewModel.swift
//  CitySearch
//
//  Created by Paulo Correa on 14/11/2564 BE.
//

import Core
import SearchEngine
import CoreLocation

class CityDetailViewModel: ViewModelType {
    private let coordinateBinder: Binder<CLLocationCoordinate2D>

    struct Input {

    }
    struct Output {
        let coordinate: Binder<CLLocationCoordinate2D>
    }

    let input: Input
    let output: Output

    init(coordinate: CLLocationCoordinate2D) {
        coordinateBinder = .init(coordinate)
        
        input = Input()
        output = Output(coordinate: coordinateBinder)
    }
}
