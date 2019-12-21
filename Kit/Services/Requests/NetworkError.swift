//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import Alamofire

public enum NetworkError: Error {
    case responseDataIsEmpty(response: AFDataResponse<Any>)
    case decodeFailed(response: AFDataResponse<Any>)
    case generalFailed(response: AFDataResponse<Any>)
}

// MARK: Public
public extension NetworkError {
    var message: String {
        switch self {
        case .responseDataIsEmpty:
            return "Response Data Is Empty"
        case .decodeFailed:
            return "Decode Data is Failed"
        case .generalFailed:
            return "Request was Failed"
        }
    }
}
