//
// Created by OVO on 07/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

struct MovieDetails: Codable {
    let adult: Bool
    private let backdropPath: String?
    let belongsToCollection: BelongsToCollection?
    let budget: Double
    let genres: [Genre]
    let homepage: String?
    let id: Int
    let imdbId: String?
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    private let posterPath: String?
    let productionCompanies: [ProductionCompany]
    let productionCountries: [ProductionCountry]
    let releaseDate: String
    let revenue: Double
    let runtime: Int?
    let spokenLanguages: [Language]
    let status: String
    let tagline: String
    let title: String
    private let video: Bool
    let videos: Videos
    let voteAverage: Double
    let voteCount: Int
}

// MARK: BelongsToCollection
extension MovieDetails {
    struct BelongsToCollection: Codable {
        let id: Int
        let name: String
        let posterPath: String?
        let backdropPath: String?
    }
}

// MARK: ProductionCompany
extension MovieDetails {
    struct ProductionCompany: Codable {
        let id: Int
        let logoPath: String?
        let name: String
        let originCountry: String
    }
}

// MARK: ProductionCountry
extension MovieDetails {
    struct ProductionCountry: Codable {
        let iso31661: String
        let name: String
    }
}

// MARK: Language
extension MovieDetails {
    struct Language: Codable {
        let iso6391: String
        let name: String
    }
}

// MARK: Public
extension MovieDetails {
    var backdropString: String {
        if let backdropPath = belongsToCollection?.backdropPath {
            return Urls.images.string +
                ConfigurationManager.shared.backdropMediumSize + backdropPath
        } else if let backdropPath = backdropPath {
            return Urls.images.string +
                ConfigurationManager.shared.backdropMediumSize + backdropPath
        } else {
            return ""
        }
    }
    
    var posterString: String {
        if let posterPath = posterPath {
            return Urls.images.string + ConfigurationManager.shared.posterSmallSize + posterPath
        } else {
            return ""
        }
    }
}
