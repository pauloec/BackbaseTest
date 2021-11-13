//
//  CitySearchCoordinator.swift
//  BackbaseTest
//
//  Created by Paulo Correa on 12/11/2564 BE.
//

import Core
import SearchEngine
import CoreLocation

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

        viewModel.output.didSelectCoordinate.bind(listener: { [weak self] coordinate in
            guard let coordinate = coordinate else { return }
            self?.navigateToMap(with: coordinate)
        })
    }

    private func navigateToMap(with coordinate: CLLocationCoordinate2D) {
        let viewModel = CityDetailViewModel(coordinate: coordinate)
        let viewController = CityDetailViewController()
        viewController.configViewModel(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
