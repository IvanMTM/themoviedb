//
// Created by OVO on 07/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import UIKit

private typealias DataSource = UITableViewDiffableDataSource<Section, ListDiffable>
private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, ListDiffable>

private enum Section: CaseIterable {
    case main, loading
}

final class MovieReviewsDataSource: NSObject {
    private weak var tableView: UITableView!
    private var dataSource: DataSource!
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        registerCells()
        setDataSource()
    }
}

// MARK: Public
extension MovieReviewsDataSource {
    func update(viewModels: [ListDiffable]) {
        var snapshot = Snapshot()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(viewModels, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: Private
private extension MovieReviewsDataSource {
    func registerCells() {
        tableView.registerNib(MovieReviewCell.self)
        tableView.registerNib(LoadingTableCell.self)
    }
}

// MARK: DataSource
private extension MovieReviewsDataSource {
    func setDataSource() {
        dataSource = DataSource(
            tableView: tableView,
            cellProvider: { (tableView, indexPath, viewModel) -> UITableViewCell? in
                switch viewModel {
                case let vm as MovieReviewViewModel:
                    let cell = tableView.dequeueClass(MovieReviewCell.self)
                    cell.bind(viewModel: vm)
                    return cell
                case _ as LoadingCellViewModel:
                    let cell = tableView.dequeueClass(LoadingTableCell.self)
                    return cell
                default:
                    return nil
                }
            })
    }
}
