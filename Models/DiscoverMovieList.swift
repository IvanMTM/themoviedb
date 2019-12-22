//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
//

public typealias Movie = DiscoverMovieList.Result

public struct DiscoverMovieList: Codable {
    public let page: Int
    let totalResults: Int
    public let totalPages: Int
    public let results: [Result]
}

// MARK: Result
public extension DiscoverMovieList {
    struct Result: Codable {
        let popularity: Double
        let voteCount: Int
        let video: Bool
        public let posterPath: String
        public let id: Int
        let adult: Bool
        let backdropPath: String
        let originalLanguage: String
        let originalTitle: String
        let genreIds: [Int]
        public let title: String
        let voteAverage: Double
        let overview: String
        let releaseDate: String
        
        enum CodingKeys: String, CodingKey {
            case popularity, voteCount, video, posterPath, id, adult, backdropPath, originalLanguage
            case originalTitle, genreIds, title, voteAverage, overview, releaseDate
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            popularity = try container.decodeIfPresent(Double.self, forKey: .popularity) ?? 0
            voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount) ?? 0
            video = try container.decodeIfPresent(Bool.self, forKey: .video) ?? false
            posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath) ?? ""
            id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
            adult = try container.decodeIfPresent(Bool.self, forKey: .adult) ?? false
            backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath) ?? ""
            originalLanguage = try container.decodeIfPresent(String.self, forKey: .originalLanguage) ?? ""
            originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle) ?? ""
            genreIds = try container.decodeIfPresent([Int].self, forKey: .genreIds) ?? []
            title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
            voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage) ?? 0
            overview = try container.decodeIfPresent(String.self, forKey: .overview) ?? ""
            releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate) ?? ""
        }
    }
}
