//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import Alamofire

struct ListGenreRequest: Request {
    let url: String = Urls.genreList.string
}
