//
//  CityDetailViewController.swift
//  CitySearch
//
//  Created by Paulo Correa on 14/11/2564 BE.
//

import UIKit
import Core
import MapKit

class CityDetailViewController: UIViewController {
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.isScrollEnabled = false
        return mapView
    }()

    typealias ViewModelType = CityDetailViewModel
    private var viewModel: ViewModelType!

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
    }
}

extension CityDetailViewController: ControllerType {
    func configViewModel(viewModel: ViewModelType) {
        self.viewModel = viewModel
    }

    func setupViews() {
        view.addSubview(mapView)
        mapView.anchorSuperview()
    }

    func bindViewModel() {
        viewModel.output.coordinate.bind(listener: { [weak self] coordinate in
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            self?.mapView.addAnnotation(annotation)
            self?.mapView.setCenter(coordinate, animated: true)
        })
    }
}
