//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import Foundation

final class DiscoverMoviesWireframe {
    private weak var viewController: DiscoverMoviesViewController!
    
    func create(genre: Genre) -> DiscoverMoviesViewController {
        let vc = DiscoverMoviesViewController()
        let viewModel = DiscoverMoviesViewModel(genre: genre)
        viewController = vc
        vc.viewModel = viewModel
        vc.wireframe = self
        return vc
    }
}

// MARK: Public
extension DiscoverMoviesWireframe {
    func showDetail(movie: Movie) {
        let vc = MovieReviewsWireframe().create(movieId: movie.id, title: movie.title)
        viewController.navigationController?.present(vc, animated: true)
    }
}
