//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import Alamofire
import Foundation

protocol Request {
    var method: HTTPMethod { get }
    var url: String { get }
    var parameters: [String: Any]? { get }
    var additionalHeaders: [String: String]? { get }
    var encoding: Encoding { get }
}

// MARK: Public
extension Request {
    func perform<T: Codable>(completion: @escaping (Result<T, NetworkError>) -> Void) -> DataRequest {
        let request = dataRequest.responseJSON(queue: .global(qos: .userInitiated)) { response in
            print(response)
            var taskCompletion: Result<T, NetworkError>
            switch response.result {
            case .success:
                do {
                    guard let data = response.data else {
                        taskCompletion = .failure(.responseDataIsEmpty(response: response))
                        break
                    }
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let model = try decoder.decode(T.self, from: data)
                    taskCompletion = .success(model)
                } catch {
                    taskCompletion = .failure(.decodeFailed(response: response))
                }
            case .failure:
                taskCompletion = .failure(.generalFailed(response: response))
            }
            DispatchQueue.main.async {
                completion(taskCompletion)
            }
        }
        return request
    }
}

// MARK: default value
extension Request {
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var additionalHeaders: [String: String]? {
        return nil
    }
    
    var encoding: Encoding {
        switch method {
        case .get: return .url
        default: return .json
        }
    }
}

// MARK: Private
private extension Request {
    var dataRequest: DataRequest {
        let sessionManager = Alamofire.Session.default
        return sessionManager.requestCall(
            method, url, parameters: parameters, encoding: encoding, additionalHeaders: additionalHeaders)
    }
}

// MARK: Encoding
enum Encoding {
    case url, json
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .url : return URLEncoding()
        case .json: return JSONEncoding()
        }
    }
}
