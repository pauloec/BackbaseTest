//
//  CitySearchViewController.swift
//  CitySearch
//
//  Created by Paulo Correa on 12/11/2564 BE.
//

import UIKit
import Core

class CitySearchViewController: UIViewController {
    typealias ViewModelType = CitySearchViewModel
    private var viewModel: ViewModelType!

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(nibName: nil, bundle: nil)

        self.title = "City Search"

        view.backgroundColor = .white
        setupViews()
    }
}

extension CitySearchViewController: ControllerType {
    func configViewModel(viewModel: ViewModelType) {
        //
    }

    func setupViews() {
        //
    }

    func bindViewModel() {
        //
    }
}
