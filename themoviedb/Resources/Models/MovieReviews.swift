//
// Created by OVO on 07/12/19.
// Copyright © 2019 OVO. All rights reserved.
//

typealias Review = MovieReviews.Result

struct MovieReviews: Codable {
    let id: Int
    let page: Int
    let results: [Result]
    let totalPages: Int
    let totalResults: Int
}

// MARK: Results
extension MovieReviews {
    struct Result: Codable {
        let author: String
        let content: String
        let id: String
        let url: String
    }
}
