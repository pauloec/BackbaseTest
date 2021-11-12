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

    struct Input {

    }
    struct Output {
        let name: Binder<String>
    }

    let input: Input
    let output: Output

    init(city: CityModel) {
        nameBinder = .init(city.name)

        input = Input()
        output = Output(name: nameBinder)
    }
}
