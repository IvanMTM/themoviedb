//
// Created by OVO on 07/12/19.
// Copyright © 2019 OVO. All rights reserved.
//

public struct Videos: Codable {
    public let results: [Video]
}

public struct Video: Codable {
    let id: String
    let iso6391: String
    let iso31661: String
    public let key: String
    let name: String
    let site: String
    let size: Int
    let type: String
}
