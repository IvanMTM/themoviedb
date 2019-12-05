//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import Foundation

final class ListGenreMoviesWireframe {
    private weak var viewController: ListGenreMoviesViewController!
    
    func create() -> ListGenreMoviesViewController {
        let vc = ListGenreMoviesViewController()
        let viewModel = ListGenreMoviesViewModel()
        viewController = vc
        vc.viewModel = viewModel
        vc.wireframe = self
        return vc
    }
}
