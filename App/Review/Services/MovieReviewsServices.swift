//
// Created by OVO on 07/12/19.
// Copyright © 2019 OVO. All rights reserved.
//

import Alamofire
import Kit
import Models
import APIServices

final class MovieReviewsServices {
    private var getReviewsRequest: DataRequest?
    
    func getReviews(movieId: String, page: Int, completion: @escaping (Result<MovieReviews, NetworkError>) -> Void) {
        guard getReviewsRequest?.task?.state != .running else {
            return
        }
        getReviewsRequest = ReviewRequest(movieId: movieId, page: page).perform(completion: completion)
    }
}
