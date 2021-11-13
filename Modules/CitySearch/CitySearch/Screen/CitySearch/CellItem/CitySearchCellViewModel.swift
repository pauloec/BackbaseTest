//
//  CitySearchCellViewModel.swift
//  Core
//
//  Created by Paulo Correa on 13/11/2564 BE.
//

import Core
import SearchEngine

class CitySearchCellViewModel: ViewModelType {
    private let nameBinder: Binder<String>
    private let coordinateBinder: Binder<String>

    struct Input {

    }
    struct Output {
        let name: Binder<String>
        let coordinate: Binder<String>
    }

    let input: Input
    let output: Output

    init(city: CityModel) {
        nameBinder = .init("\(city.name), \(city.country)")
        coordinateBinder = .init("Latitidude: \(city.coord.lat) Longitude: \(city.coord.lon)")

        input = Input()
        output = Output(name: nameBinder,
                        coordinate: coordinateBinder)
    }
}
