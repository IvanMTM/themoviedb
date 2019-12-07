//
// Created by OVO on 07/12/19.
// Copyright © 2019 OVO. All rights reserved.
//

import Foundation

final class DetailMovieImagesViewModel {
    private let backdropString: String
    private let posterString: String
    let reviewTapCompletion: () -> Void
    
    init(backdropString: String, posterString: String, reviewTapCompletion: @escaping () -> Void) {
        self.backdropString = backdropString
        self.posterString = posterString
        self.reviewTapCompletion = reviewTapCompletion
    }
}

// MARK: Public
extension DetailMovieImagesViewModel {
    var backdropUrl: URL? {
        return URL(string: backdropString)
    }
    
    var posterUrl: URL? {
        return URL(string: posterString)
    }
}
