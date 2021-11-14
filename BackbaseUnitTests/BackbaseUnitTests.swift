//
//  BackbaseUnitTests.swift
//  BackbaseUnitTests
//
//  Created by Paulo Correa on 14/11/2564 BE.
//

import XCTest
import CoreLocation
@testable import CitySearch

class BackbaseUnitTests: XCTestCase {
    var citySearchViewModel: CitySearchViewModel!

    override func setUp() {
        citySearchViewModel = CitySearchViewModel()
    }

    func testValidSearch() {
        let expectation = XCTestExpectation(description: "Filtered Cities")

        citySearchViewModel.input.didInputSearch.value = "Porto Alegre"

        citySearchViewModel.output.cities.bind(listener: { cities in
            XCTAssertEqual(1, cities.count)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 1)
    }

    func testInvalidSearch() {
        let expectation = XCTestExpectation(description: "No Result")

        citySearchViewModel.input.didInputSearch.value = "okwdPMDIWmi"

        citySearchViewModel.output.cities.bind(listener: { cities in
            XCTAssertNil(cities.first)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 1)
    }

    func testCoordinateSelection() {
        let expectation = XCTestExpectation(description: "Selected Coordinate from filtered Cities")

        citySearchViewModel.input.didInputSearch.value = "Porto Alegre"

        citySearchViewModel.output.cities.bind(listener: { [weak self] cities in
            self?.citySearchViewModel.input.didSelectCell.value = 0
        })

        citySearchViewModel.output.didSelectCoordinate.bind(listener: { coordinate in
            XCTAssertNotNil(coordinate)
            XCTAssertEqual(-51.23, coordinate?.longitude)
            XCTAssertEqual(-30.03306, coordinate?.latitude)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 1)
    }
}
