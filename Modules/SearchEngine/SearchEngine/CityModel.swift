//
//  Parser.swift
//  BackbaseTest
//
//  Created by Paulo Correa on 12/11/2564 BE.
//

import Foundation

public struct CityModel: Decodable, Equatable, Hashable {
    let _id: Int
    public let name: String
    public let country: String
    public let coord: Coordinates
    
    public static func == (lhs:CityModel, rhs:CityModel) -> Bool {
        return lhs._id == rhs._id
    }
}

public struct Coordinates: Decodable, Hashable {
    public let lon: Double
    public let lat: Double
}
