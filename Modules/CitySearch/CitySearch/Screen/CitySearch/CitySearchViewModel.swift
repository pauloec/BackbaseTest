//
//  CitySearchViewModel.swift
//  CitySearch
//
//  Created by Paulo Correa on 12/11/2564 BE.
//

import Core
import SearchEngine

class CitySearchViewModel: ViewModelType {
    private let searchEngine = SearchEngine.shared()

    struct Input {

    }
    struct Output {

    }

    let input: Input
    let output: Output

    init() {
        input = Input()
        output = Output()

        searchEngine.searchCity(input: "Porto", completion: { [weak self] cities in
            let cityNames = cities.map { $0.name }
            print(cityNames)
        })
    }
}
