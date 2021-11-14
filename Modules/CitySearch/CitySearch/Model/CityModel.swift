//
//  Parser.swift
//  BackbaseTest
//
//  Created by Paulo Correa on 12/11/2564 BE.
//

import Foundation
import SearchEngine

public class CityModel: Decodable {
    let _id: Int
    public let name: String
    public let country: String
    public let coord: Coordinates
}

public struct Coordinates: Decodable {
    public let lon: Double
    public let lat: Double
}
