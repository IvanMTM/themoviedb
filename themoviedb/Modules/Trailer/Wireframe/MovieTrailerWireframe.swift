//
// Created by OVO on 07/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

final class MovieTrailerWireframe {
    private weak var viewController: MovieTrailerViewController!
    
    func create(videos: Videos) -> MovieTrailerViewController {
        let vc = MovieTrailerViewController()
        let viewModel = MovieTrailerViewModel(videos: videos)
        viewController = vc
        vc.viewModel = viewModel
        vc.wireframe = self
        return vc
    }
}
