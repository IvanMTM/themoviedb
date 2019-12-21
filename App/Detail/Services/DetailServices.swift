//
// Created by OVO on 07/12/19.
// Copyright © 2019 OVO. All rights reserved.
//

import Kit

final class DetailServices {
    func getMovieDetail(movieId: String, completion: @escaping (Result<MovieDetails, NetworkError>) -> Void) {
        _ = MovieDetailRequest(id: movieId).perform(completion: completion)
    }
}
