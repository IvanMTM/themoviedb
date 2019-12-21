//
// Created by OVO on 07/12/19.
// Copyright © 2019 OVO. All rights reserved.
//

public struct MovieDetailRequest: Request {
    let id: String
    public var url: String {
        return Urls.detail(id: id)
    }
    
    public let parameters:[String: Any]? = [
        "append_to_response": "videos"
    ]
    
    public init(id: String) {
        self.id = id
    }
}
