//
//  CitySearchBundle.swift
//  BackbaseTest
//
//  Created by Paulo Correa on 12/11/2564 BE.
//

import Foundation

public enum CitySearchFramework {
    public static let useResourceBundles = true
    public static let bundleName = "CitySearch.bundle"
}

private class GetBundle {}

extension Bundle {
    public class func CitySearchResourceBundle() -> Bundle {
        let framework = Bundle(for: GetBundle.self)
        guard CitySearchFramework.useResourceBundles else {
            return framework
        }
        guard let resourceBundleURL = framework.url(
            forResource: CitySearchFramework.bundleName,
            withExtension: nil)
        else {
            fatalError("\(CitySearchFramework.bundleName) not found!")
        }
        guard let resourceBundle = Bundle(url: resourceBundleURL) else {
            fatalError("Cannot access \(CitySearchFramework.bundleName)")
        }
        return resourceBundle
    }
}

extension UIImage {
    class func image(named: String) -> UIImage {
        return UIImage(named: named, in: Bundle.CitySearchResourceBundle(), compatibleWith: nil) ?? UIImage()
    }
}
