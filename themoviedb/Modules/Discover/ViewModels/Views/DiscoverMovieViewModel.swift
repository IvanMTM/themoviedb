//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import Foundation

final class DiscoverMovieViewModel: ListDiffable {
    let imageString: String
    let title: String
    
    init(id: Int, imageString: String, title: String) {
        self.imageString = imageString
        self.title = title
        super.init(id: id)
    }
}
