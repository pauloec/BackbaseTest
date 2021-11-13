//
//  CitySearchViewModel.swift
//  CitySearch
//
//  Created by Paulo Correa on 12/11/2564 BE.
//

import Core
import SearchEngine
import CoreLocation

class CitySearchViewModel: ViewModelType {
    private let searchEngine = SearchEngine.shared()

    private let didInputSearchBinder: Binder<String> = .init("")
    private let didSelectCellBinder: Binder<Int?> = .init(nil)

    private let citiesBinder: Binder<[CitySearchCellViewModel]> = .init([])
    private let didSelectCoordinateBinder: Binder<CLLocationCoordinate2D?> = .init(nil)

    struct Input {
        let didInputSearch: Binder<String>
        let didSelectCell: Binder<Int?>
    }
    struct Output {
        let cities: Binder<[CitySearchCellViewModel]>
        let didSelectCoordinate: Binder<CLLocationCoordinate2D?>
    }

    let input: Input
    let output: Output

    init() {
        input = Input(didInputSearch: didInputSearchBinder,
                      didSelectCell: didSelectCellBinder)
        output = Output(cities: citiesBinder,
                        didSelectCoordinate: didSelectCoordinateBinder)

        observeBind()
    }

    private func observeBind() {
        didInputSearchBinder.bind(listener: { [weak self] text in
            guard let self = self else { return }
            self.searchEngine.searchCity(input: text,
                                         completion: { cities in
                let citiesViewModel = cities.map { CitySearchCellViewModel(city: $0) }
                self.citiesBinder.value = citiesViewModel
            })
        })

        didSelectCellBinder.bind(listener: { [weak self] index in
            guard let self = self, let index = index else { return }
            let cityViewModel = self.citiesBinder.value[index]
            self.didSelectCoordinateBinder.value = cityViewModel.output.coordinate.value
        })
    }
}
