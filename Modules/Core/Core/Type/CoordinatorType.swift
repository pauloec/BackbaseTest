//
//  CoordinatorType.swift
//  BackbaseTest
//
//  Created by Paulo Correa on 12/11/2564 BE.
//

import UIKit

public protocol CoordinatorType {
    var navigationController: UINavigationController { get set }
    func start()
}
