//
// Created by OVO on 07/12/19.
// Copyright © 2019 OVO. All rights reserved.
//

import Kit

final class MovieReviewViewModel: ListDiffable {
    let author: String
    let content: String
    
    init(id: Int, author: String, content: String) {
        self.author = author
        self.content = content
        super.init(id: id)
    }
}
