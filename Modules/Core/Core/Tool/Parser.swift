//
//  Parser.swift
//  BackbaseTest
//
//  Created by Paulo Correa on 12/11/2564 BE.
//

import Foundation

public enum ParserError: Error {
    case runtimeError(String)
}

public struct Parser {
    static public func parseList<Element: Decodable>(path: String) throws -> Array<Element> {
        do {
            let start = DispatchTime.now()

            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            let list = try JSONDecoder().decode([Element].self, from: data)

            let end = DispatchTime.now()

            let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
            let timeInterval = Double(nanoTime) / 1000000000
            print("\(list.count) Items Parsed in: \(timeInterval) seconds")

            return list
        } catch let error {
            throw ParserError.runtimeError("Error Decoding Json:\(error)")
        }
    }
}
