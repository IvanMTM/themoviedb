//
// Created by OVO on 07/12/19.
// Copyright © 2019 OVO. All rights reserved.
//

import Kit
import Models
import ReviewMovie
import TrailerMovie

public final class DetailMovieWireframe {
    private weak var viewController: DetailMovieViewController!
    
    public init() {}
    
    public func create(movie: Movie) -> DetailMovieViewController {
        let vc = DetailMovieViewController()
        let viewModel = DetailMovieViewModel(movie: movie)
        viewController = vc
        vc.viewModel = viewModel
        vc.wireframe = self
        return vc
    }
}

// MARK: Public
public extension DetailMovieWireframe {
    func showReview(movie: Movie) {
        let vc = MovieReviewsWireframe().create(movieId: movie.id, title: movie.title)
        viewController.navigationController?.present(vc, animated: true)
    }
    
    func showTrailers(videos: Videos) {
        let vc = MovieTrailerWireframe().create(videos: videos)
        viewController.show(vc, sender: nil)
    }
}
