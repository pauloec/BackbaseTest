//
//  SearchEngineBundle.swift
//  BackbaseTest
//
//  Created by Paulo Correa on 12/11/2564 BE.
//

import Foundation

public enum SearchEngineFramework {
    public static let useResourceBundles = true
    public static let bundleName = "SearchEngine.bundle"
}

private class GetBundle {}

extension Bundle {
    public class func SearchEngineResourceBundle() -> Bundle {
        let framework = Bundle(for: GetBundle.self)
        guard SearchEngineFramework.useResourceBundles else {
            return framework
        }
        guard let resourceBundleURL = framework.url(
            forResource: SearchEngineFramework.bundleName,
            withExtension: nil)
        else {
            fatalError("\(SearchEngineFramework.bundleName) not found!")
        }
        guard let resourceBundle = Bundle(url: resourceBundleURL) else {
            fatalError("Cannot access \(SearchEngineFramework.bundleName)")
        }
        return resourceBundle
    }
}

extension UIImage {
    class func image(named: String) -> UIImage {
        return UIImage(named: named, in: Bundle.SearchEngineResourceBundle(), compatibleWith: nil) ?? UIImage()
    }
}
