//
//  CitySearchCellViewModel.swift
//  Core
//
//  Created by Paulo Correa on 13/11/2564 BE.
//

import Core
import SearchEngine
import CoreLocation

class CitySearchCellViewModel: ViewModelType {
    private let nameBinder: Binder<String>
    private let coordinateBinder: Binder<CLLocationCoordinate2D>

    struct Input {

    }
    struct Output {
        let name: Binder<String>
        let coordinate: Binder<CLLocationCoordinate2D>
    }

    let input: Input
    let output: Output

    init(city: CityModel) {
        nameBinder = .init("\(city.name), \(city.country)")
        coordinateBinder = .init(CLLocationCoordinate2D(latitude: city.coord.lat,
                                                        longitude: city.coord.lon))

        input = Input()
        output = Output(name: nameBinder,
                        coordinate: coordinateBinder)
    }
}
