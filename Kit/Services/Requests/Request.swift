//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import Alamofire
import Foundation

public protocol Request {
    var method: HTTPMethod { get }
    var url: String { get }
    var parameters: [String: Any]? { get }
    var additionalHeaders: [String: String]? { get }
    var encoding: Encoding { get }
}

// MARK: Public
public extension Request {
    func perform<T: Codable>(completion: @escaping (Result<T, NetworkError>) -> Void) -> DataRequest {
        print("request: \(url)")
        let request = dataRequest.responseJSON(queue: .global(qos: .userInitiated)) { response in
            print(response.request?.url?.absoluteString ?? "")
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
                    print(response)
                } catch {
                    taskCompletion = .failure(.decodeFailed(response: response))
                    print("error parse: \(error)")
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
    public var method: HTTPMethod {
        return .get
    }
    public   
    var parameters: [String: Any]? {
        return nil
    }
    
    public var additionalHeaders: [String: String]? {
        return nil
    }
    public   
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
public enum Encoding {
    case url, json
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .url : return URLEncoding()
        case .json: return JSONEncoding()
        }
    }
}
