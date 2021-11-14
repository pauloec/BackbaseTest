//
//  SearchEngine.swift
//  SearchEngine
//
//  Created by Paulo Correa on 13/11/2564 BE.
//

import Foundation

public struct SearchEngine {
    static public func search<Element: BinarySearchable>(input: String,
                                                         list: Array<Element>,
                                                         completion: (Array<Element>) -> Void) {
        guard !list.isEmpty else {
            completion(list)
            return
        }

        // Record Search Start Time
        let start = DispatchTime.now()

        // Setup Bounds of Search
        var lowerBound = 0
        var upperBound = list.count - 1
        var middleIndex: Int = lowerBound + (upperBound - lowerBound) / 2

        // Initialize temporary list
        var filteredList = Array<Element>()

        // Binary Search
        while lowerBound <= upperBound {
            if list[middleIndex].searchable.lowercased().hasPrefix(input.lowercased()) {
                // Lower bound of the slice
                for index in (list.startIndex...middleIndex).reversed() {
                    guard list[index].searchable.lowercased().hasPrefix(input.lowercased()) else { break }
                    lowerBound = index
                }
                // After the lower bound has been finished, we check the higher bound
                for index in (middleIndex...list.endIndex - 1) {
                    guard list[index].searchable.lowercased().hasPrefix(input.lowercased()) else { break }
                    upperBound = index
                }

                break
            } else {
                if (input.lowercased() > list[middleIndex].searchable.lowercased()) {
                    lowerBound = middleIndex + 1
                } else {
                    upperBound = middleIndex - 1
                }

                middleIndex = lowerBound + (upperBound - lowerBound) / 2
            }
        }

        if lowerBound <= upperBound {
            filteredList.append(contentsOf: list[lowerBound...upperBound])
        }
        
        completion(filteredList)

        let end = DispatchTime.now()
        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
        let timeInterval = Double(nanoTime) / 1000000000
        print("Search in: \(timeInterval) seconds")
        print("Items: \((upperBound + 1) - lowerBound)")
    }
}
