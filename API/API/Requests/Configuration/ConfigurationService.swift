//
// Created by OVO on 06/12/19.
// Copyright © 2019 OVO. All rights reserved.
//

import Models

public final class ConfigurationService {
    func get(completion: @escaping (Result<Configuration, NetworkError>) -> Void) {
            _ = ConfigurationRequest().perform(completion: completion)
    }
}

// MARK: Manager
public final class ConfigurationManager {
    public static let shared = ConfigurationManager()
    private var configuration: Configuration?
}

// MARK: Public
public extension ConfigurationManager {
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
    
    var basePosterSmallSizeUrl: String {
        return baseImageUrl + posterSmallSize
    }
    
    var baseBackdropSmallSize: String {
        return baseImageUrl + backdropSmallSize
    }
    
    var baseBackdropMediumSize: String {
        return baseImageUrl + backdropMediumSize
    }
}

// MARK: Private
private extension ConfigurationManager {
    var baseImageUrl: String {
        return configuration?.images.baseUrl ?? ""
    }
    
    var posterSmallSize: String {
        return configuration?.images.posterSizes[safe: 1] ??
               configuration?.images.posterSizes.first ?? "w154"
    }
    
    var backdropSmallSize: String {
        return configuration?.images.backdropSizes.first ?? "w300"
    }
    
    var backdropMediumSize: String {
        return configuration?.images.backdropSizes[safe: 1] ?? "w780"
    }
}

private extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
