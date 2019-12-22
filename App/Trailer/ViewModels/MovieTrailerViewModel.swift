//
// Created by OVO on 07/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import Foundation
import Combine
import Kit
import Models

protocol MovieTrailerViewModelOutput: BaseViewModelOutput {
    var updatePlayerViews: AnyPublisher<[String], Never> { get }
}

protocol MovieTrailerViewModelInput: BaseViewModelInput {}

protocol MovieTrailerViewModelType {
    var input: MovieTrailerViewModelInput { get }
    var output: MovieTrailerViewModelOutput { get }
}

final class MovieTrailerViewModel: BaseViewModel {
    let updatePlayerViewsSubject = PassthroughSubject<[String], Never>()
    
    let videos: Videos
    
    init(videos: Videos) {
        self.videos = videos
    }
}

// MARK: MovieTrailerViewModelInput
extension MovieTrailerViewModel: MovieTrailerViewModelInput {
    func onViewDidLoad() {
        let youtubeIds = videos.results.map { $0.key }
        updatePlayerViewsSubject.send(youtubeIds)
    }
}

// MARK: MovieTrailerViewModelOutput
extension MovieTrailerViewModel: MovieTrailerViewModelOutput {
    var updatePlayerViews: AnyPublisher<[String], Never> {
        return updatePlayerViewsSubject.eraseToAnyPublisher()
    }
}

// MARK: MovieTrailerViewModelType
extension MovieTrailerViewModel: MovieTrailerViewModelType {
    var input: MovieTrailerViewModelInput {
        return self
    }
    var output: MovieTrailerViewModelOutput {
        return self
    }
}
