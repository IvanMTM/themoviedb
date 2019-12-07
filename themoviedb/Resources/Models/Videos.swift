//
// Created by OVO on 07/12/19.
// Copyright © 2019 OVO. All rights reserved.
//

struct Videos: Codable {
    let results: [Video]
}

struct Video: Codable {
    let id: String
    let iso6391: String
    let iso31661: String
    let key: String
    let name: String
    let site: String
    let size: Int
    let type: String
}
