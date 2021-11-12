//
//  Parser.swift
//  BackbaseTest
//
//  Created by Paulo Correa on 12/11/2564 BE.
//

import Foundation

enum EngineError: Error {
    case runtimeError(String)
}

struct Parser {
    static func parseCities(completion: (Set<CityModel>) -> Void, failure: (EngineError) -> Void) {
        if let path = Bundle.main.path(forResource: "cities", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let cities = try Set(JSONDecoder().decode([CityModel].self, from: data))
                completion(cities)
            } catch let error {
                failure(EngineError.runtimeError("Error Decoding Json:\(error)"))
            }
        } else {
            failure(EngineError.runtimeError("File Not Found!"))
        }
    }
}
