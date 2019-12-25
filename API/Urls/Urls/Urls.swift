//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
//

public enum Urls: String {
    var base: String { return "https://api.themoviedb.org/3" }
    
    case base
    
    case configuration = "/configuration"
    case genreList = "/genre/movie/list"
    case discover = "/discover/movie"
    
    public static func review(id: String) -> String {
        return Urls.detail(id: id) + "/reviews"
    }
    
    public static func detail(id: String) -> String {
        return Urls.base.string + "/movie/\(id)"
    }
}

// MARK: Public
public extension Urls {
    var string: String {
        switch self {
        case .base  : return base
        default     : return base + rawValue
        }
    }
}
