//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import UIKit
import Combine

final class DiscoverMoviesViewController: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: DiscoverMoviesViewModelType!
    var wireframe: DiscoverMoviesWireframe!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.input.onViewDidLoad()
        
        UITableViewDiffableDataSource
    }
}

// MARK: Private
private extension DiscoverMoviesViewController {
    func setupView() {}
}
