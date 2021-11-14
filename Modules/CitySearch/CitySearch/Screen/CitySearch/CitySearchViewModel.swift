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
    private let didInputSearchBinder: Binder<String> = .init("")
    private let didSelectCellBinder: Binder<Int?> = .init(nil)

    private let filteredViewModelBinder: Binder<[CitySearchCellViewModel]> = .init([])
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

    // Internal Control
    private let citiesViewModel: [CitySearchCellViewModel]
    private var querySearch = ""

    init() {
        input = Input(didInputSearch: didInputSearchBinder,
                      didSelectCell: didSelectCellBinder)
        output = Output(cities: filteredViewModelBinder,
                        didSelectCoordinate: didSelectCoordinateBinder)

        guard let path = Bundle.CitySearchResourceBundle().path(forResource: "cities", ofType: "json"),
              let parsedCities: [CityModel] = try? Parser.parseList(path: path) else {
                  citiesViewModel = []
                  print("uh.. oh no file!")
                  return
              }
        let cities = parsedCities.sorted { $0.name.lowercased() < $1.name.lowercased() } 
        citiesViewModel = cities.map { CitySearchCellViewModel(city: $0) }
        filteredViewModelBinder.value = citiesViewModel

        observeBind()
    }

    private func observeBind() {
        didInputSearchBinder.bind(listener: { [weak self] text in
            guard let self = self, !text.isEmpty else {
                self?.filteredViewModelBinder.value = self?.citiesViewModel ?? []
                self?.querySearch = ""
                return
            }

            let list = text.lowercased().contains(self.querySearch.lowercased()) ? self.filteredViewModelBinder.value : self.citiesViewModel
            self.querySearch = text

            SearchEngine.search(input: text,
                                list: list,
                                completion: { list in
                self.filteredViewModelBinder.value = list
            })
        })

        didSelectCellBinder.bind(listener: { [weak self] index in
            guard let self = self, let index = index else { return }
            let cityViewModel = self.filteredViewModelBinder.value[index]
            self.didSelectCoordinateBinder.value = cityViewModel.output.coordinate.value
        })
    }
}
