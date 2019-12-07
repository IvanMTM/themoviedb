//
// Created by OVO on 07/12/19.
// Copyright © 2019 OVO. All rights reserved.
//

struct MovieDetailRequest: Request {
    let id: String
    var url: String {
        return Urls.detail(id: id)
    }
    
    let parameters:[String: Any]? = [
        "append_to_response": "videos"
    ]
    
    init(id: String) {
        self.id = id
    }
}
