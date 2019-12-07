//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import UIKit
import Combine

final class DiscoverMoviesViewController: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: DiscoverMoviesDataSource!
    var viewModel: DiscoverMoviesViewModelType!
    var wireframe: DiscoverMoviesWireframe!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
        viewModel.input.onViewDidLoad()
    }
}

// MARK: Private
private extension DiscoverMoviesViewController {
    func setupView() {
        dataSource = DiscoverMoviesDataSource(collectionView: collectionView)
    }
    
    func bindViewModel() {
        viewModel.output.updateCollection.sink { [weak self] cellViewModels in
            self?.dataSource.update(viewModels: cellViewModels)
        }.store(in: &subscriptions)
        
        viewModel.output.title.sink { [weak self] title in
            self?.title = title
        }.store(in: &subscriptions)
        
        viewModel.output.showLoading.sink { [weak self] shouldShow in
            shouldShow ? self?.view.showLoadingView() : self?.view.hideLoadingView()
        }.store(in: &subscriptions)
        
        viewModel.output.showAlert.sink { [weak self] message in
            
        }.store(in: &subscriptions)
        
        viewModel.output.showDetailMovie.sink { [weak self] movie in
            self?.wireframe.showDetail(movie: movie)
        }.store(in: &subscriptions)
    }
}
