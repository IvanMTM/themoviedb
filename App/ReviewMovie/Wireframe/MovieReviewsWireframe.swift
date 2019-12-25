//
// Created by OVO on 07/12/19.
// Copyright © 2019 OVO. All rights reserved.
//

public final class MovieReviewsWireframe {
    private weak var viewController: MovieReviewsViewController!
    
    public init() {}
    
    public func create(movieId: Int, title: String) -> MovieReviewsViewController {
        let vc = MovieReviewsViewController()
        let viewModel = MovieReviewsViewModel(movieId: movieId, title: title)
        viewController = vc
        vc.viewModel = viewModel
        vc.wireframe = self
        return vc
    }
}
