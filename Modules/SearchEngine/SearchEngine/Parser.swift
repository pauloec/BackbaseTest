//
//  Parser.swift
//  BackbaseTest
//
//  Created by Paulo Correa on 12/11/2564 BE.
//

import Foundation

struct Parser {
    static func parseCities(completion: (Array<CityModel>) -> Void, failure: (EngineError) -> Void) {
        if let path = Bundle.SearchEngineResourceBundle().path(forResource: "cities", ofType: "json") {
            do {
                let start = DispatchTime.now()

                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let cities = try JSONDecoder().decode([CityModel].self, from: data)
                completion(cities)

                let end = DispatchTime.now()

                let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
                let timeInterval = Double(nanoTime) / 1000000000
                print("\(cities.count) Cities Parsed in: \(timeInterval) seconds")
            } catch let error {
                failure(EngineError.runtimeError("Error Decoding Json:\(error)"))
            }
        } else {
            failure(EngineError.fileNotFound("File Not Found!"))
        }
    }
}
