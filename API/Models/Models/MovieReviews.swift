//
// Created by OVO on 07/12/19.
// Copyright © 2019 OVO. All rights reserved.
//

public typealias Review = MovieReviews.Result

public struct MovieReviews: Codable {
    let id: Int
    public let page: Int
    public let results: [Result]
    public let totalPages: Int
    let totalResults: Int
}

// MARK: Results
public extension MovieReviews {
    struct Result: Codable {
        public let author: String
        public let content: String
        let id: String
        let url: String
    }
}
