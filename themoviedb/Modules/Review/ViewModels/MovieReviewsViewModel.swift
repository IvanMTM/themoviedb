//
// Created by OVO on 07/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import Foundation
import Combine

protocol MovieReviewsViewModelOutput {
    var showLoading: AnyPublisher<Bool, Never> { get }
    var showTitle: AnyPublisher<String, Never> { get }
    var updateCollection: AnyPublisher<[ListDiffable], Never> { get }
    var showEmpty: AnyPublisher<Bool, Never> { get }
}

protocol MovieReviewsViewModelInput {
    func onViewDidLoad()
    func onLoadMore()
}

protocol MovieReviewsViewModelType {
    var input: MovieReviewsViewModelInput { get }
    var output: MovieReviewsViewModelOutput { get }
}

final class MovieReviewsViewModel {
    private let showLoadingSubject = PassthroughSubject<Bool, Never>()
    private let showTitleSubject = PassthroughSubject<String, Never>()
    private let updateCollectionSubject = PassthroughSubject<[ListDiffable], Never>()
    private let showEmptySubject = PassthroughSubject<Bool, Never>()
    
    private let movieId: Int
    private let title: String
    private var page = 1
    private var totalPages: Int?
    private var canLoadMore: Bool {
        guard let totalPages = totalPages, page <= totalPages else {
            return false
        }
        return true
    }
    
    private var reviews = [Review]()
    private var items: [ListDiffable] {
        var items: [ListDiffable] = reviewViewModels
        if let loadingViewModel = loadingViewModel {
            items += [loadingViewModel]
        }
        return items
    }
    private var loadingViewModel: LoadingCellViewModel? {
        return canLoadMore ? LoadingCellViewModel(
            id: 0,
            onDisplayCompletion: { [weak self] in
                self?.onLoadMore()
        }) : nil
    }
    private var reviewViewModels: [MovieReviewViewModel] {
        return reviews.enumerated().map {
            MovieReviewViewModel(id: $0.offset, author: $0.element.author, content: $0.element.content)
        }
    }
    
    init(movieId: Int, title: String) {
        self.movieId = movieId
        self.title = title
    }
}

// MARK: Private
private extension MovieReviewsViewModel {
    func requestReviews() {
        if reviews.isEmpty { showLoadingSubject.send(true) }
        MovieReviewsServices().getReviews(movieId: "\(movieId)", page: page) { [weak self] result in
            guard let self = self else { return }
            if self.reviews.isEmpty { self.showLoadingSubject.send(false) }
            switch result {
            case .success(let model):
                if model.results.isEmpty {
                    self.showEmptySubject.send(true)
                } else {
                    self.reviews += model.results
                    self.page = model.page + 1
                    self.totalPages = model.totalPages
                    self.updateCollectionSubject.send(self.items)
                }
            case .failure:
                guard self.reviews.isEmpty else {
                    return
                }
                self.showEmptySubject.send(true)
            }
        }
    }
}

// MARK: MovieReviewsViewModelInput
extension MovieReviewsViewModel: MovieReviewsViewModelInput {
    func onViewDidLoad() {
        requestReviews()
        showTitleSubject.send(title)
    }
    
    func onLoadMore() {
        guard canLoadMore else { return }
        requestReviews()
    }
}

// MARK: MovieReviewsViewModelOutput
extension MovieReviewsViewModel: MovieReviewsViewModelOutput {
    var showLoading: AnyPublisher<Bool, Never> {
        return showLoadingSubject.eraseToAnyPublisher()
    }
    
    var showTitle: AnyPublisher<String, Never> {
        return showTitleSubject.eraseToAnyPublisher()
    }
    
    var updateCollection: AnyPublisher<[ListDiffable], Never> {
        return updateCollectionSubject.eraseToAnyPublisher()
    }
    
    var showEmpty: AnyPublisher<Bool, Never> {
        return showEmptySubject.eraseToAnyPublisher()
    }
}

// MARK: MovieReviewsViewModelType
extension MovieReviewsViewModel: MovieReviewsViewModelType {
    var input: MovieReviewsViewModelInput {
        return self
    }
    var output: MovieReviewsViewModelOutput {
        return self
    }
}
