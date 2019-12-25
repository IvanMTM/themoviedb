//
// Created by OVO on 07/12/19.
// Copyright © 2019 OVO. All rights reserved.
//

import Kit
import Models
import API

final class DetailServices {
    func getMovieDetail(movieId: String, completion: @escaping (Result<MovieDetails, NetworkError>) -> Void) {
        _ = MovieDetailRequest(id: movieId).perform { (result: Result<MovieDetails, NetworkError>) in
            switch result {
            case .success(let model):
                var backdropString: String {
                    if let backdropPath = model.belongsToCollection?.backdropPath {
                        return ConfigurationManager.shared.baseBackdropMediumSize + backdropPath
                    } else if let backdropPath = model.backdropPath {
                        return ConfigurationManager.shared.baseBackdropMediumSize + backdropPath
                    } else {
                        return ""
                    }
                }
                var posterString: String {
                    if let posterPath = model.posterPath {
                        return ConfigurationManager.shared.basePosterSmallSizeUrl + posterPath
                    } else {
                        return ""
                    }
                }
                model.backdropString = backdropString
                model.posterString = posterString
            default: break
            }
            completion(result)
        }
    }
}
