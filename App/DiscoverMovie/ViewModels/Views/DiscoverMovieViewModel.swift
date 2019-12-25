//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import Foundation
import Kit

final class DiscoverMovieViewModel: ListDiffable {
    let imageString: String
    let tapCompletion: () -> Void
    
    init(id: Int, imageString: String, tapCompletion: @escaping () -> Void) {
        self.imageString = imageString
        self.tapCompletion = tapCompletion
        super.init(id: id)
    }
}

// MARK: Public
extension DiscoverMovieViewModel {
    var urlImage: URL? {
        return URL(string: imageString)
    }
}
