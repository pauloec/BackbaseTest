//
//  Parser.swift
//  BackbaseTest
//
//  Created by Paulo Correa on 12/11/2564 BE.
//

import Foundation

public enum EngineError: Error {
    case runtimeError(String)
    case fileNotFound(String)
}

public struct Parser {
    static public func parseCities(completion: (Set<CityModel>) -> Void, failure: (EngineError) -> Void) {
        if let path = Bundle.SearchEngineResourceBundle().path(forResource: "cities", ofType: "json") {
            do {
                let start = DispatchTime.now()

                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let cities = try Set(JSONDecoder().decode([CityModel].self, from: data))
                completion(cities)

                let end = DispatchTime.now()

                let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
                let timeInterval = Double(nanoTime) / 1000000000
                print("\(cities.count) Cities Parsed in: \(timeInterval) milliseconds")
            } catch let error {
                failure(EngineError.runtimeError("Error Decoding Json:\(error)"))
            }
        } else {
            failure(EngineError.fileNotFound("File Not Found!"))
        }
    }
}
