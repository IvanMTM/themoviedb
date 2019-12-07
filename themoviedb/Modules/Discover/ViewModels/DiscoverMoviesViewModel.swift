//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import Foundation
import Combine

protocol DiscoverMoviesViewModelOutput {
    var updateTableView: AnyPublisher<[ListDiffable], Never> { get }
    var title: AnyPublisher<String, Never> { get }
    var showLoading: AnyPublisher<Bool, Never> { get }
}

protocol DiscoverMoviesViewModelInput {
    func onViewDidLoad()
}

protocol DiscoverMoviesViewModelType {
    var input: DiscoverMoviesViewModelInput { get }
    var output: DiscoverMoviesViewModelOutput { get }
}

final class DiscoverMoviesViewModel {
    private let updateTableViewSubject = PassthroughSubject<[ListDiffable], Never>()
    private let titleSubject = PassthroughSubject<String, Never>()
    private let showLoadingSubject = PassthroughSubject<Bool, Never>()
    
    private let genre: Genre
    private var page = 1
    private let perPage = 20
    
    private var movies = [DiscoverMovieList.Result]()
    private var items: [ListDiffable] {
        let items: [ListDiffable] = movieViewModels + [loadingViewModel]
        return items
    }
    private var loadingViewModel: LoadingCellViewModel {
        return LoadingCellViewModel(
            id: 0,
            onDisplayCompletion: { [weak self] in
                self?.requestMovies()
        })
    }
    private var movieViewModels: [DiscoverMovieViewModel] {
        return movies.map {
            DiscoverMovieViewModel(
                id: $0.id,
                imageString: Urls.images.string + ConfigurationManager.shared.posterSmallSize + $0.posterPath,
                tapCompletion: { [weak self] in
                    
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
                self.updateTableViewSubject.send(self.items)
            case .failure(let error):
                break
            }
        }
    }
}

// MARK: DiscoverMoviesViewModelInput
extension DiscoverMoviesViewModel: DiscoverMoviesViewModelInput {
    func onViewDidLoad() {
        requestMovies()
        titleSubject.send(genre.name)
    }
}

// MARK: DiscoverMoviesViewModelOutput
extension DiscoverMoviesViewModel: DiscoverMoviesViewModelOutput {
    var updateTableView: AnyPublisher<[ListDiffable], Never> {
        return updateTableViewSubject.eraseToAnyPublisher()
    }
    
    var title: AnyPublisher<String, Never> {
        return titleSubject.eraseToAnyPublisher()
    }
    
    var showLoading: AnyPublisher<Bool, Never> {
        return showLoadingSubject.eraseToAnyPublisher()
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
