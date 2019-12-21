//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import UIKit
import Kit

public final class ListGenreMoviesWireframe {
    private weak var viewController: ListGenreMoviesViewController!
    
    public func create() -> ListGenreMoviesViewController {
        let vc = ListGenreMoviesViewController()
        let viewModel = ListGenreMoviesViewModel()
        viewController = vc
        vc.viewModel = viewModel
        vc.wireframe = self
        return vc
    }
    
    public init() {}
}

// MARK: Public
extension ListGenreMoviesWireframe {
    func showDiscoverMoviesViewController(genre: Genre) {
        let vc = DiscoverMoviesWireframe().create(genre: genre)
        viewController.show(vc, sender: nil)
    }
}
