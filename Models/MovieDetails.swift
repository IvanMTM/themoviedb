//
// Created by OVO on 07/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

public class MovieDetails: Codable {
    let adult: Bool
    public let backdropPath: String?
    public let belongsToCollection: BelongsToCollection?
    let budget: Double
    private let genres: [Genre]
    let homepage: String?
    let id: Int
    let imdbId: String?
    let originalLanguage: String
    let originalTitle: String
    public let overview: String
    let popularity: Double
    public let posterPath: String?
    let productionCompanies: [ProductionCompany]
    let productionCountries: [ProductionCountry]
    let releaseDate: String
    let revenue: Double
    let runtime: Int?
    let spokenLanguages: [Language]
    let status: String
    let tagline: String
    public let title: String
    private let video: Bool
    public let videos: Videos
    let voteAverage: Double
    let voteCount: Int
    
    public var backdropString: String?
    public var posterString: String?
}

// MARK: BelongsToCollection
public extension MovieDetails {
    struct BelongsToCollection: Codable {
        let id: Int
        let name: String
        let posterPath: String?
        public let backdropPath: String?
    }
}

// MARK: ProductionCompany
public extension MovieDetails {
    struct ProductionCompany: Codable {
        let id: Int
        let logoPath: String?
        let name: String
        let originCountry: String
    }
}

// MARK: ProductionCountry
public extension MovieDetails {
    struct ProductionCountry: Codable {
        let iso31661: String
        let name: String
    }
}

// MARK: Language
public extension MovieDetails {
    struct Language: Codable {
        let iso6391: String
        let name: String
    }
}

// MARK: Public
public extension MovieDetails {
    var joinedGenres: String {
        return genres.map { $0.name }.joined(separator: ", ")
    }
    
    var joinedSpokenLanguages: String {
        return spokenLanguages.map { $0.name }.joined(separator: ", ")
    }
    
    var joinedCountries: String {
        return productionCountries.map { $0.name }.joined(separator: ", ")
    }
    
    var joinedCompanies: String {
        return productionCompanies.map { $0.name }.joined(separator: ", ")
    }
    
    var displayItems: [String: String] {
        var items = [String: String]()
        items["Popularity"] = "\(popularity)"
        items["Genre"]      = joinedGenres
        items["Release"]    = releaseDate
        items["Language"]   = joinedSpokenLanguages
        items["Country"]    = joinedCountries
        items["Company"]    = joinedCompanies
        if let homepage = homepage {
            items["homepage"] = homepage
        }
        if let runtime = runtime {
            items["Duration"] = "\(runtime) min"
        }
        if voteAverage > 0 {
            items["Rating"] = "\(voteAverage) / 10 from \(voteCount) users"
        }
        return items
    }
}
