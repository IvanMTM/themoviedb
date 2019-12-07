//
// Created by OVO on 06/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import Foundation

struct Configuration: Codable {
    let images: Images
    let changeKeys: [String]
}

// MARK: Images
extension Configuration {
    struct Images: Codable {
        let baseUrl: String
        let secureBaseUrl: String
        let backdropSizes: [String]
        let logoSizes: [String]
        let posterSizes: [String]
        let profileSizes: [String]
        let stillSizes: [String]
    }
}
