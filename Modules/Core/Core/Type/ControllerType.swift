//
//  ControllerType.swift
//  BackbaseTest
//
//  Created by Paulo Correa on 12/11/2564 BE.
//

import Foundation

public protocol ControllerType {
    associatedtype ViewModelType
    func configViewModel(viewModel: ViewModelType)
    func bindViewModel()
    func setupViews()
}
