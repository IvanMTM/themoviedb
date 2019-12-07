//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
//

struct GenreList: Codable {
    let genres: [Genre]
}

// MARK: Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
