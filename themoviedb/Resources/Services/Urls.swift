//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
//

enum Urls: String {
    var base: String { return "https://api.themoviedb.org/3" }
    
    case images
    case configuration = "/configuration"
    case genreList = "/genre/movie/list"
    case discover = "/discover/movie"
}

// MARK: Public
extension Urls {
    var string: String {
        switch self {
        case .images: return ConfigurationManager.shared.baseImageUrl
        default     : return base + rawValue
        }
    }
}
