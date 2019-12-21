//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import Foundation
import Combine
import Kit

protocol DiscoverMoviesViewModelOutput: BaseViewModelOutput {
    var updateCollection: AnyPublisher<[ListDiffable], Never> { get }
    var showDetailMovie: AnyPublisher<Movie, Never> { get }
}

protocol DiscoverMoviesViewModelInput: BaseViewModelInput {
    func onLoadMore()
}

protocol DiscoverMoviesViewModelType {
    var input: DiscoverMoviesViewModelInput { get }
    var output: DiscoverMoviesViewModelOutput { get }
}

final class DiscoverMoviesViewModel: BaseViewModel {
    private let updateCollectionSubject = PassthroughSubject<[ListDiffable], Never>()
    private let showDetailMovieSubject = PassthroughSubject<Movie, Never>()
    
    private let genre: Genre
    private var page = 1
    private var totalPages: Int?
    private var canLoadMore: Bool {
        guard let totalPages = totalPages, page <= totalPages else {
            return false
        }
        return true
    }
    
    private var movies = [Movie]()
    private var items: [ListDiffable] {
        var items: [ListDiffable] = movieViewModels
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
    private var movieViewModels: [DiscoverMovieViewModel] {
        return movies.map { (movie) -> DiscoverMovieViewModel in
            return DiscoverMovieViewModel(
                id: movie.id,
                imageString: Urls.images.string + ConfigurationManager.shared.posterSmallSize + movie.posterPath,
                tapCompletion: { [weak self] in
                    self?.showDetailMovieSubject.send(movie)
            })
        }
    }
    
    init(genre: Genre) {
        self.genre = genre
    }
}

// MARK: Private
private extension DiscoverMoviesViewModel {
    func requestMovies() {
        if movies.isEmpty { showLoadingSubject.send(true) }
        DiscoverMoviesServices().getMoviesBy(genre: "\(genre.id)", page: page) { [weak self] result in
            guard let self = self else { return }
            if self.movies.isEmpty { self.showLoadingSubject.send(false) }
            switch result {
            case .success(let model):
                self.movies += model.results
                self.page = model.page + 1
                self.totalPages = model.totalPages
                self.updateCollectionSubject.send(self.items)
            case .failure(let error):
                self.showAlertSubject.send(error.message)
            }
        }
    }
}

// MARK: DiscoverMoviesViewModelInput
extension DiscoverMoviesViewModel: DiscoverMoviesViewModelInput {
    func onViewDidLoad() {
        requestMovies()
        showTitleSubject.send(genre.name)
    }
    
    func onLoadMore() {
        guard canLoadMore else {
            return
        }
        requestMovies()
    }
}

// MARK: DiscoverMoviesViewModelOutput
extension DiscoverMoviesViewModel: DiscoverMoviesViewModelOutput {
    var updateCollection: AnyPublisher<[ListDiffable], Never> {
        return updateCollectionSubject.eraseToAnyPublisher()
    }
    
    var showDetailMovie: AnyPublisher<Movie, Never> {
        return showDetailMovieSubject.eraseToAnyPublisher()
    }
}

// MARK: DiscoverMoviesViewModelType
extension DiscoverMoviesViewModel: DiscoverMoviesViewModelType {
    var input: DiscoverMoviesViewModelInput {
        return self
    }
    
    var output: DiscoverMoviesViewModelOutput {
        return self
    }
}
