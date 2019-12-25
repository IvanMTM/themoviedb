//
// Created by OVO on 06/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

public struct Configuration: Codable {
    public let images: Images
    let changeKeys: [String]
}

// MARK: Images
public extension Configuration {
    struct Images: Codable {
        public let baseUrl: String
        let secureBaseUrl: String
        public let backdropSizes: [String]
        let logoSizes: [String]
        public let posterSizes: [String]
        let profileSizes: [String]
        let stillSizes: [String]
    }
}
