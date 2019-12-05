//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import Foundation

final class DiscoverMoviesWireframe {
    private weak var viewController: DiscoverMoviesViewController!
    
    func create(genreId: String) -> DiscoverMoviesViewController {
        let vc = DiscoverMoviesViewController()
        let viewModel = DiscoverMoviesViewModel(genreId: genreId)
        viewController = vc
        vc.viewModel = viewModel
        vc.wireframe = self
        return vc
    }
}

// MARK: Public
extension DiscoverMoviesWireframe {
}
