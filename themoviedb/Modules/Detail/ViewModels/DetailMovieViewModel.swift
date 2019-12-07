//
// Created by OVO on 07/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import Foundation
import Combine

protocol DetailMovieViewModelOutput {
    var updateImageView: AnyPublisher<DetailMovieImagesViewModel, Never> { get }
    var updateTitleSubtitleView: AnyPublisher<DetailMovieTitleSubtitleViewModel, Never> { get }
    var updateInformationViews: AnyPublisher<[DetailMovieInformationViewModel], Never> { get }
    var showLoading: AnyPublisher<Bool, Never> { get }
    var showAlert: AnyPublisher<String, Never> { get }
    var showReviews: AnyPublisher<Movie, Never> { get }
}

protocol DetailMovieViewModelInput {
    func onViewDidLoad()
}

protocol DetailMovieViewModelType {
    var input: DetailMovieViewModelInput { get }
    var output: DetailMovieViewModelOutput { get }
}

final class DetailMovieViewModel {
    private let updateImageViewSubject = PassthroughSubject<DetailMovieImagesViewModel, Never>()
    private let updateTitleSubtitleViewSubject = PassthroughSubject<DetailMovieTitleSubtitleViewModel, Never>()
    private let updateInformationViewsSubject = PassthroughSubject<[DetailMovieInformationViewModel], Never>()
    private let showLoadingSubject = PassthroughSubject<Bool, Never>()
    private let showAlertSubject = PassthroughSubject<String, Never>()
    private let showReviewsSubject = PassthroughSubject<Movie, Never>()
    
    let movie: Movie
    var detail: MovieDetails?
    
    var imageViewModel: DetailMovieImagesViewModel? {
        guard let detail = detail else { return nil }
        return DetailMovieImagesViewModel(
            backdropString: detail.backdropString,
            posterString: detail.posterString,
            reviewTapCompletion: { [weak self] in
                guard let self = self else { return }
                self.showReviewsSubject.send(self.movie)
        })
    }
    var titleSubtitleViewModel: DetailMovieTitleSubtitleViewModel? {
        guard let detail = detail else { return nil }
        return DetailMovieTitleSubtitleViewModel(title: detail.title, subtitle: detail.overview)
    }
    var informationViewModels: [DetailMovieInformationViewModel] {
        guard let detail = detail else { return [] }
        return detail.displayItems.map {
            DetailMovieInformationViewModel(key: $0.key, value: $0.value)
        }
    }
    
    init(movie: Movie) {
        self.movie = movie
    }
}

// MARK: Private
private extension DetailMovieViewModel {
    func requestDetail() {
        showLoadingSubject.send(true)
        DetailServices().getMovieDetail(movieId: "\(movie.id)") { [weak self] result in
            guard let self = self else { return }
            self.showLoadingSubject.send(false)
            switch result {
            case .success(let model):
                self.detail = model
                self.updateDataToView()
            case .failure(let error):
                self.showAlertSubject.send(error.message)
            }
        }
    }
    
    func updateDataToView() {
        if let imageViewModel = imageViewModel {
            updateImageViewSubject.send(imageViewModel)
        }
        if let titleSubtitleViewModel = titleSubtitleViewModel {
            updateTitleSubtitleViewSubject.send(titleSubtitleViewModel)
        }
        updateInformationViewsSubject.send(informationViewModels)
    }
}

// MARK: DetailMovieViewModelInput
extension DetailMovieViewModel: DetailMovieViewModelInput {
    func onViewDidLoad() {
        requestDetail()
    }
}

// MARK: DetailMovieViewModelOutput
extension DetailMovieViewModel: DetailMovieViewModelOutput {
    var updateImageView: AnyPublisher<DetailMovieImagesViewModel, Never> {
        return updateImageViewSubject.eraseToAnyPublisher()
    }
    
    var updateTitleSubtitleView: AnyPublisher<DetailMovieTitleSubtitleViewModel, Never> {
        return updateTitleSubtitleViewSubject.eraseToAnyPublisher()
    }
    
    var updateInformationViews: AnyPublisher<[DetailMovieInformationViewModel], Never> {
        return updateInformationViewsSubject.eraseToAnyPublisher()
    }
    
    var showLoading: AnyPublisher<Bool, Never> {
        return showLoadingSubject.eraseToAnyPublisher()
    }
    
    var showAlert: AnyPublisher<String, Never> {
        return showAlertSubject.eraseToAnyPublisher()
    }
    
    var showReviews: AnyPublisher<Movie, Never> {
        return showReviewsSubject.eraseToAnyPublisher()
    }
}

// MARK: DetailMovieViewModelType
extension DetailMovieViewModel: DetailMovieViewModelType {
    var input: DetailMovieViewModelInput {
        return self
    }
    var output: DetailMovieViewModelOutput {
        return self
    }
}
