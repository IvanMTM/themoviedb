//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import Alamofire

// MARK: Public
extension Alamofire.Session {
    func requestCall(
        _ method: HTTPMethod, _ url: String, parameters: Parameters? = nil,
        encoding: Encoding = .url, additionalHeaders: [String: String]? = nil) -> DataRequest {
            let allHeaders = appendDefaultHeaders(to: additionalHeaders)
            let requestHeaders = HTTPHeaders(allHeaders)
            let paramWithLanguage = appendDefaultParams(to: parameters)
            return request(url, method: method, parameters: paramWithLanguage, encoding: encoding.parameterEncoding,
                headers: requestHeaders).validate()
    }
}

// MARK: Private
private extension Alamofire.Session {
    var headers: [String: String] {
        return auth
    }
    
    var auth: [String: String] {
        return ["Authorization": Authorization.bearerToken.value]
    }
    
    var apiKey: [String: Any] {
        return ["api_key": Authorization.apiKey.value]
    }
    
    var language: [String: Any] {
        return ["language": "en-US"]
    }
    
    func appendDefaultParams(to params: [String: Any]?) -> [String: Any] {
        var nParams = params ?? [:]
        nParams = nParams + language + apiKey
        return nParams
    }
    
    func appendDefaultHeaders(to additionalHeaders: [String: String]?) -> [String: String] {
        var headers = self.headers
        if let additionalHeaders = additionalHeaders {
            headers = headers + additionalHeaders
        }
        return headers
    }
}

private extension Dictionary {
    static func +(l: Dictionary, r: Dictionary?) -> Dictionary {
        guard let r = r else { return l }
        return r.reduce(l) {
            var nres = $0
            nres[$1.key] = $1.value
            return nres
        }
    }
}
