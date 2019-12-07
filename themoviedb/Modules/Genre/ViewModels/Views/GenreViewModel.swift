//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import Foundation

final class GenreViewModel {
    private let genre: Genre
    private var _tapCompletion: (Genre) -> Void
    lazy var tapCompletion: () -> Void = {
        return { [weak self] in
            guard let self = self else { return }
            self._tapCompletion(self.genre)
        }
    }()
    
    init(genre: Genre, tapCompletion: @escaping (Genre) -> Void) {
        self.genre = genre
        self._tapCompletion = tapCompletion
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
