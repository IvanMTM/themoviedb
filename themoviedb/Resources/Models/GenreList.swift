//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import Foundation

typealias Genre = GenreList.Genre

struct GenreList: Codable {
    let genres: [Genre]
}

// MARK: Genre
extension GenreList {
    struct Genre: Codable {
        let id: Int
        let name: String
    }
}
