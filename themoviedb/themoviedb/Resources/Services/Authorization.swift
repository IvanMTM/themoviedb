//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
//

/// example api request
/// https://api.themoviedb.org/3/movie/550?api_key=0fa5fc61c248cc9050a25d5333eade92
enum Authorization: String {
    case apiKey = "0fa5fc61c248cc9050a25d5333eade92"
    case bearerToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwZmE1ZmM2MWMyNDhjYzkwNTBhMjVkNTMzM2VhZGU5MiIsInN1YiI6IjVkZTg2OGYyYTdlMzYzMDAxNDczM2JmZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.sFH0ajHWyxax_Fjt7rb6UX3cageEyq-eLFXqWbxS-is"
}

// MARK: Public
extension Authorization {
    var value: String { return rawValue }
}
