//
//  SearchEngine.swift
//  SearchEngine
//
//  Created by Paulo Correa on 13/11/2564 BE.
//

import Foundation

final public class SearchEngine {
    private static var sharedEngine: SearchEngine = {
        let searchEngine = SearchEngine()
        return searchEngine
    }()

    class public func shared() -> SearchEngine {
        return sharedEngine
    }

    private var cityList: Array<CityModel>
    private var filteredList = Array<CityModel>.init()
    private var isSearching: Bool = false
    private var querySearch: String = ""
    private var searchWorkItem: DispatchWorkItem?

    private init() {
        self.cityList = []

        Parser.parseCities(completion: { [unowned self] cities in
            self.cityList = cities.sorted { $0.name < $1.name }
        }, failure: { error in
            switch error {
            case .runtimeError(let error):
                print(error)
            case .fileNotFound(let error):
                print(error)
            }
        })
    }

    public func searchCity(input: String,
                           completion: @escaping (Array<CityModel>) -> Void) {

        // Reset search in case of empty request
        if input.isEmpty {
            self.isSearching = false
            self.querySearch = ""
            self.filteredList.removeAll(keepingCapacity: false)
            completion(cityList)
        } else {
            let searchWork = DispatchWorkItem { [unowned self] in
                self.isSearching = true
                // If we're narrowing down the search, we reuse the already filtered result
                self.filter(input: input, list: input.contains(self.querySearch) ? self.filteredList : self.cityList)

                DispatchQueue.main.async {
                    completion(filteredList)
                }

                self.searchWorkItem = nil
            }

            searchWorkItem = searchWork
            let dispatchQueue = DispatchQueue(label: "Filter.array")

            // We filter valid search requests
            dispatchQueue.async(execute: searchWork)
        }
    }

    private func filter(input: String, list: [CityModel]) {
        if list.count == 0 { return }

        let start = DispatchTime.now()
        querySearch = input

        var lowerBound = 0
        var upperBound = list.count - 1
        var middleIndex: Int = lowerBound + (upperBound - lowerBound) / 2

        var hasFoundLower: Bool = false
        var hasFoundUpper: Bool = false

        while hasFoundLower == false && hasFoundUpper == false {
            if list[middleIndex].name.lowercased().hasPrefix(input.lowercased()) {
                if (input.lowercased() > list[middleIndex].name.lowercased()) {
                    for index in (middleIndex...list.startIndex) {
                        if list[index].name.lowercased().hasPrefix(input.lowercased()) {
                            lowerBound = index
                        } else {
                            hasFoundLower = true

                            for index in (middleIndex...list.endIndex - 1).reversed() {
                                if list[index].name.lowercased().hasPrefix(input.lowercased()) {
                                    upperBound = index
                                } else {
                                    hasFoundUpper = true
                                    break
                                }
                            }

                            break
                        }
                    }
                } else {
                    for index in (middleIndex...list.endIndex - 1) {
                        if list[index].name.lowercased().hasPrefix(input.lowercased()) {
                            upperBound = index
                        } else {
                            hasFoundUpper = true

                            for index in (list.startIndex...middleIndex).reversed() {
                                if list[index].name.lowercased().hasPrefix(input.lowercased()) {
                                    lowerBound = index
                                } else {
                                    hasFoundLower = true
                                    break
                                }
                            }

                            break
                        }
                    }
                }
            } else {
                if (input.lowercased() > list[middleIndex].name.lowercased()) {
                    lowerBound = middleIndex + 1
                } else {
                    upperBound = middleIndex - 1
                }

                middleIndex = lowerBound + (upperBound - lowerBound) / 2
            }
        }

        filteredList.removeAll(keepingCapacity: false)
        filteredList.append(contentsOf: list[lowerBound...upperBound])

        let end = DispatchTime.now()

        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
        let timeInterval = Double(nanoTime) / 1000000000
        print("Search in: \(timeInterval) seconds")
        print("Cities: \(filteredList.count)")
    }
}

