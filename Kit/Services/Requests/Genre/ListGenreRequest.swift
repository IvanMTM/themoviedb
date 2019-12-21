//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

public struct ListGenreRequest: Request {
    public let url: String = Urls.genreList.string
    
    public init() {}
}
