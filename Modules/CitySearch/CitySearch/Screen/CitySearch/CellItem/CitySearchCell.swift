//
//  CitySearchCell.swift
//  Core
//
//  Created by Paulo Correa on 13/11/2564 BE.
//

import UIKit
import Core

class CitySearchCell: UITableViewCell {
    private let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    static let cellIdentifier = "SearchCellIdentifier"
    typealias ViewModelType = CitySearchCellViewModel
    private var viewModel: ViewModelType!

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        setupViews()
    }
}

extension CitySearchCell: ControllerType {
    func configViewModel(viewModel: ViewModelType) {
        self.viewModel = viewModel
        bindViewModel()
    }

    func setupViews() {
        contentView.addSubview(nameLabel)
        nameLabel.anchor(top: contentView.safeAreaLayoutGuide.topAnchor,
                         leading: contentView.safeAreaLayoutGuide.leadingAnchor,
                         bottom: contentView.safeAreaLayoutGuide.bottomAnchor,
                         trailing: contentView.safeAreaLayoutGuide.trailingAnchor,
                         padding: .init(top: 20, left: 20, bottom: 10, right: 20))
    }

    func bindViewModel() {
        viewModel.output.name.bind(listener: { [weak self] name in
            self?.nameLabel.text = name
        })
    }
}
