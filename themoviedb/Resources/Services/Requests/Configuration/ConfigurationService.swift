//
// Created by OVO on 06/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import Foundation

final class ConfigurationService {
    func get(completion: @escaping (Result<Configuration, NetworkError>) -> Void) {
            _ = ConfigurationRequest().perform(completion: completion)
    }
}

// MARK: Manager
final class ConfigurationManager {
    static let shared = ConfigurationManager()
    private var configuration: Configuration?
}

// MARK: Public
extension ConfigurationManager {
    var baseImageUrl: String {
        return configuration?.images.baseUrl ?? ""
    }
    
    var posterSmallSize: String {
        return configuration?.images.posterSizes[safe: 1] ??
               configuration?.images.posterSizes.first ?? "w154"
    }
    
    func getConfiguration() {
        ConfigurationService().get { [weak self] result in
            switch result {
            case .success(let model):
                self?.configuration = model
            case .failure:
                break
            }
        }
    }
}
