//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import Models
import DetailMovie

public final class DiscoverMoviesWireframe {
    private weak var viewController: DiscoverMoviesViewController!
    
    public init() {}
    
    public func create(genre: Genre) -> DiscoverMoviesViewController {
        let vc = DiscoverMoviesViewController()
        let viewModel = DiscoverMoviesViewModel(genre: genre)
        viewController = vc
        vc.viewModel = viewModel
        vc.wireframe = self
        return vc
    }
}

// MARK: Public
public extension DiscoverMoviesWireframe {
    func showDetail(movie: Movie) {
        let vc = DetailMovieWireframe().create(movie: movie)
        viewController.show(vc, sender: nil)
    }
}
