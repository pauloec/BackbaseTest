//
//  CitySearchCoordinator.swift
//  BackbaseTest
//
//  Created by Paulo Correa on 12/11/2564 BE.
//

import Core

public class CitySearchCoordinator: CoordinatorType {
    public var navigationController: UINavigationController

    public required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        let viewModel = CitySearchViewModel()
        let viewController = CitySearchViewController()
        viewController.configViewModel(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
