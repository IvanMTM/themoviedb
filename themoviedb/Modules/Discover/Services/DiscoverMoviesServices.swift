//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import Alamofire

final class DiscoverMoviesServices {
    private var getMoviesRequest: DataRequest?
    
    func getMoviesBy(
        genre: String, page: Int, completion: @escaping (Result<DiscoverMovieList, NetworkError>) -> Void) {
            guard getMoviesRequest?.task?.state != .running else {
                return
            }
            getMoviesRequest = DiscoverRequest(byGenres: [genre], page: page).perform(completion: completion)
    }
}
