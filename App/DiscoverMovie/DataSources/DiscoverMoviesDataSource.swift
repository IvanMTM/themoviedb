//
// Created by OVO on 06/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import UIKit
import Kit
import Ui_Kit

private typealias DataSource = UICollectionViewDiffableDataSource<Section, ListDiffable>
private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, ListDiffable>

private enum Section: CaseIterable {
    case main, loading
}

final class DiscoverMoviesDataSource: NSObject {
    private weak var collectionView: UICollectionView!
    private var dataSource: DataSource!
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        collectionView.delegate = self
        registerCells()
        setDataSource()
    }
}

// MARK: Public
extension DiscoverMoviesDataSource {
    func update(viewModels: [ListDiffable]) {
        var snapshot = Snapshot()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(viewModels, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: Private
private extension DiscoverMoviesDataSource {
    func registerCells() {
        collectionView.registerNib(DiscoverMovieCell.self)
        collectionView.registerNib(LoadingCollectionCell.self)
    }
}

// MARK: DataSource
private extension DiscoverMoviesDataSource {
    func setDataSource() {
        dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, viewModel) -> UICollectionViewCell? in
                switch viewModel {
                case let vm as DiscoverMovieViewModel:
                    let cell: DiscoverMovieCell = collectionView.dequeueCell(forIndexPath: indexPath)
                    cell.bind(viewModel: vm)
                    return cell
                case _ as LoadingCellViewModel:
                    let cell: LoadingCollectionCell = collectionView.dequeueCell(forIndexPath: indexPath)
                    return cell
                default:
                    return nil
                }
            })
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension DiscoverMoviesDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = UIScreen.main.bounds.width / 3
            let height = width * 1.4
            return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath) {
            guard let item = dataSource.itemIdentifier(for: indexPath) else {
                return
            }
            switch item {
            case let vm as LoadingCellViewModel:
                vm.onDisplayCompletion()
            default:
                break
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        switch item {
        case let vm as DiscoverMovieViewModel:
            vm.tapCompletion()
        default:
            break
        }
    }
}
