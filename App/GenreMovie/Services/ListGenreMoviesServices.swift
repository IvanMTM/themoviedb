//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
//

import Kit
import Models
import APIServices

final class ListGenreMoviesServices {
    func getListGenre(completion: @escaping (Result<GenreList, NetworkError>) -> Void) {
        _ = ListGenreRequest().perform(completion: completion)
    }
}
