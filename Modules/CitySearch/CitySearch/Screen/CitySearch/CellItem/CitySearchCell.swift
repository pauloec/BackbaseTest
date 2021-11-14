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

    private let countryLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 10)
        return label
    }()

    private let coordinateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    private let pinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.image(named: "pin")
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        accessoryType = .detailDisclosureButton
        setupViews()
    }
}

extension CitySearchCell: ControllerType {
    func configViewModel(viewModel: ViewModelType) {
        self.viewModel = viewModel
        bindViewModel()
    }

    func setupViews() {
        [nameLabel, countryLabel, pinImageView, coordinateLabel].forEach {
            contentView.addSubview($0)
        }
        nameLabel.anchor(top: contentView.safeAreaLayoutGuide.topAnchor,
                         leading: contentView.safeAreaLayoutGuide.leadingAnchor,
                         bottom: nil,
                         trailing: nil,
                         padding: .init(top: LayoutConstraint.NameLabel.top,
                                        left: LayoutConstraint.NameLabel.left,
                                        bottom: LayoutConstraint.NameLabel.bottom,
                                        right: LayoutConstraint.NameLabel.right))

        countryLabel.anchor(top: nameLabel.centerYAnchor,
                            leading: nameLabel.trailingAnchor,
                            bottom: nil,
                            trailing: contentView.safeAreaLayoutGuide.trailingAnchor,
                            padding: .init(top: LayoutConstraint.CountryLabel.top,
                                           left: LayoutConstraint.CountryLabel.left,
                                           bottom: LayoutConstraint.CountryLabel.bottom,
                                           right: LayoutConstraint.CountryLabel.right))

        pinImageView.anchor(top: nameLabel.bottomAnchor,
                            leading: contentView.safeAreaLayoutGuide.leadingAnchor,
                            bottom: contentView.safeAreaLayoutGuide.bottomAnchor,
                            trailing: nil,
                            padding: .init(top: LayoutConstraint.PinImageView.top,
                                           left: LayoutConstraint.PinImageView.left,
                                           bottom: LayoutConstraint.PinImageView.bottom,
                                           right: LayoutConstraint.PinImageView.right),
                            size: .init(width: LayoutConstraint.PinImageView.Size.width,
                                        height: LayoutConstraint.PinImageView.Size.height))

        coordinateLabel.anchor(top: pinImageView.topAnchor,
                               leading: pinImageView.trailingAnchor,
                               bottom: nil,
                               trailing: contentView.safeAreaLayoutGuide.trailingAnchor,
                               padding: .init(top: LayoutConstraint.CoordinateLabel.top,
                                              left: LayoutConstraint.CoordinateLabel.left,
                                              bottom: LayoutConstraint.CoordinateLabel.bottom,
                                              right: LayoutConstraint.CoordinateLabel.right))
    }

    func bindViewModel() {
        viewModel.output.name.bind(listener: { [weak self] name in
            self?.nameLabel.text = name
        })
        viewModel.output.country.bind(listener: { [weak self] country in
            self?.countryLabel.text = country
        })
        viewModel.output.coordinate.bind(listener: { [weak self] coordinate in
            self?.coordinateLabel.text = "Lat: \(coordinate.latitude) Lon: \(coordinate.longitude)"
        })
    }
}

extension CitySearchCell {
    struct LayoutConstraint {
        struct NameLabel {
            static let top: CGFloat = 20
            static let left: CGFloat = 20
            static let bottom: CGFloat = 10
            static let right: CGFloat = 20
        }
        struct CountryLabel {
            static let top: CGFloat = 0
            static let left: CGFloat = 20
            static let bottom: CGFloat = 0
            static let right: CGFloat = 20
        }
        struct PinImageView {
            static let top: CGFloat = 10
            static let left: CGFloat = 20
            static let bottom: CGFloat = 20
            static let right: CGFloat = 20
            struct Size {
                static let width: CGFloat = 20
                static let height: CGFloat = 20
            }
        }
        struct CoordinateLabel {
            static let top: CGFloat = 2
            static let left: CGFloat = 0
            static let bottom: CGFloat = 0
            static let right: CGFloat = 0
        }
    }
}
