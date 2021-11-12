//
//  CitySearchViewController.swift
//  CitySearch
//
//  Created by Paulo Correa on 12/11/2564 BE.
//

import UIKit
import Core

class CitySearchViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.register(CitySearchCell.self, forCellReuseIdentifier: CitySearchCell.cellIdentifier)
        return tableView
    }()

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search your city"
        searchBar.delegate = self
        return searchBar
    }()

    typealias ViewModelType = CitySearchViewModel
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

extension CitySearchViewController: ControllerType {
    func configViewModel(viewModel: ViewModelType) {
        self.viewModel = viewModel
    }

    func setupViews() {
        view.backgroundColor = .white
        navigationItem.titleView = searchBar

        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         leading: view.safeAreaLayoutGuide.leadingAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         trailing: view.safeAreaLayoutGuide.trailingAnchor)
    }

    func bindViewModel() {
        viewModel.output.cities.bind(listener: { [weak self] cities in
            self?.tableView.reloadData()
        })
    }
}

extension CitySearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.cities.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CitySearchCell.cellIdentifier, for: indexPath) as? CitySearchCell else {
            return UITableViewCell()
        }

        let viewModel = viewModel.output.cities.value[indexPath.row]
        cell.configViewModel(viewModel: viewModel)
        return cell
    }
}

extension CitySearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.input.didInputSearch.value = searchText
    }
}
