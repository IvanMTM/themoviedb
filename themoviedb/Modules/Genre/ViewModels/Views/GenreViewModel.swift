//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import Foundation

final class GenreViewModel {
    private let genre: GenreList.Genre
    let tapCompletion: (GenreViewModel) -> Void
    
    init(genre: GenreList.Genre, tapCompletion: @escaping (GenreViewModel) -> Void) {
        self.genre = genre
        self.tapCompletion = tapCompletion
    }
}

// MARK: Public
extension GenreViewModel {
    var title: String {
        return genre.name
    }
    
    var id: String {
        return "\(genre.id)"
    }
}
