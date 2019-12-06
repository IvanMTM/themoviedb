//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import UIKit
import Combine

private typealias DiscoverMoviesDataSource = UITableViewDiffableDataSource<Section, ListDiffable>

private enum Section {
    case main, loading
}

final class DiscoverMoviesViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var dataSource: DiscoverMoviesDataSource = {
        let dataSource = DiscoverMoviesDataSource(
            tableView: tableView,
            cellProvider: { (tableView, indexPath, viewModel) -> UITableViewCell? in
            
            })
        return dataSource
    }()
    
    var viewModel: DiscoverMoviesViewModelType!
    var wireframe: DiscoverMoviesWireframe!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.input.onViewDidLoad()
    }
}

// MARK: Private
private extension DiscoverMoviesViewController {
    func setupView() {}
}
