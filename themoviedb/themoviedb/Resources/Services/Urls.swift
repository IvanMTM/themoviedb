//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
//

enum Urls: String {
    private var base: String { return "https://api.themoviedb.org/3" }
    
    case genreList = "/genre/movie/list"
}

// MARK: Public
extension Urls {
    var string: String {
        return base + rawValue
    }
}
