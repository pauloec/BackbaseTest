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

    private let didInputSearchBinder: Binder<String> = .init("")
    private let citiesBinder: Binder<[CitySearchCellViewModel]> = .init([])

    struct Input {
        let didInputSearch: Binder<String>
    }
    struct Output {
        let cities: Binder<[CitySearchCellViewModel]>
    }

    let input: Input
    let output: Output

    init() {
        input = Input(didInputSearch: didInputSearchBinder)
        output = Output(cities: citiesBinder)

        didInputSearchBinder.bind(listener: { [weak self] text in
            guard let self = self else { return }
            self.searchEngine.searchCity(input: text,
                                         completion: { cities in
                let citiesViewModel = cities.map { CitySearchCellViewModel(city: $0) }
                self.citiesBinder.value = citiesViewModel
            })
        })
    }
}
