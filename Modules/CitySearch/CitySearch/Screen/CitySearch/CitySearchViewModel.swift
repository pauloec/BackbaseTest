//
//  CitySearchViewModel.swift
//  CitySearch
//
//  Created by Paulo Correa on 12/11/2564 BE.
//

import Core
import SearchEngine

class CitySearchViewModel: ViewModelType {
    struct Input {

    }
    struct Output {

    }

    let input: Input
    let output: Output

    init() {
        input = Input()
        output = Output()

        Parser.parseCities(completion: { [weak self] cities in
            //
        }, failure: { error in
            switch error {
            case .runtimeError(let error):
                print(error)
            case .fileNotFound(let error):
                print(error)
            }
        })
    }
}
