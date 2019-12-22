//
// Created by OVO on 07/12/19.
// Copyright © 2019 OVO. All rights reserved.
//

import Urls

public struct ReviewRequest: Request {
    let movieId: String
    let page: Int
    public var url: String {
        return Urls.review(id: movieId)
    }
    
    public init(movieId: String, page: Int) {
        self.movieId = movieId
        self.page = page
    }
}
