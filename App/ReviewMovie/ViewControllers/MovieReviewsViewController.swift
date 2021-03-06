//
// Created by OVO on 07/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import UIKit
import Combine
import Ui_Kit

public final class MovieReviewsViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: MovieReviewsDataSource!
    var viewModel: MovieReviewsViewModelType!
    var wireframe: MovieReviewsWireframe!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
        viewModel.input.onViewDidLoad()
    }
}

// MARK: Private
private extension MovieReviewsViewController {
    func setupView() {
        dataSource = MovieReviewsDataSource(tableView: tableView)
    }
    
    func bindViewModel() {
        viewModel.output.updateCollection.sink { [weak self] cellViewModels in
            self?.dataSource.update(viewModels: cellViewModels)
        }.store(in: &subscriptions)
        
        viewModel.output.showTitle.sink { [weak self] title in
            self?.title = title
        }.store(in: &subscriptions)
        
        viewModel.output.showLoading.sink { [weak self] shouldShow in
            shouldShow ? self?.view.showLoadingView() : self?.view.hideLoadingView()
        }.store(in: &subscriptions)
        
        viewModel.output.showEmpty.sink { [weak self] _ in
            let emptyView = UIView.createFromNib(EmptyMoviesReviewView.self)
            self?.view.addSubview(emptyView)
        }.store(in: &subscriptions)
    }
}
