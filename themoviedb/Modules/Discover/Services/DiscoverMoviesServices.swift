//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import Foundation

final class DiscoverMoviesServices {
    func getMoviesBy(
        genre: String, page: Int,
        completion: @escaping (Result<DiscoverMovieList, NetworkError>) -> Void) {
            _ = DiscoverRequest(byGenres: [genre], page: page).perform(completion: completion)
    }
}
