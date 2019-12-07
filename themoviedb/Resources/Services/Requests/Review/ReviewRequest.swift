//
// Created by OVO on 07/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

struct ReviewRequest: Request {
    let movieId: String
    let page: Int
    var url: String {
        return Urls.review(id: movieId)
    }
    
    init(movieId: String, page: Int) {
        self.movieId = movieId
        self.page = page
    }
}
