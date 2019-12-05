//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
//

import Foundation

/// example: https://api.themoviedb.org/3/discover/movie?api_key=0fa5fc61c248cc9050a25d5333eade92&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1
struct DiscoverRequest: Request {
    let url: String = Urls.discover.string
    var parameters: [String : Any]? {
        return [
            "sort_by"      : "popularity.desc",
            "include_adult": false,
            "include_video": false,
            "page"         : page,
            "with_genres"  : genres
        ]
    }
    
    private let genres: String
    private let page: Int
    
    init(byGenres: [String], page: Int) {
        genres = byGenres.joined(separator: ",")
        self.page = page
    }
}
