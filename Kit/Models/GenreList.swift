//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
//

public struct GenreList: Codable {
    public let genres: [Genre]
}

// MARK: Genre
public struct Genre: Codable {
    public let id: Int
    public let name: String
}
