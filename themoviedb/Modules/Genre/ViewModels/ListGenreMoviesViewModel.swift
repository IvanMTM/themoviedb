//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import Combine
import Foundation

protocol ListGenreMoviesViewModelOutput: BaseViewModelOutput {
    var showGenreList: AnyPublisher<[GenreViewModel], Never> { get }
    var showDiscoverMovies: AnyPublisher<Genre, Never> { get }
}

protocol ListGenreMoviesViewModelInput: BaseViewModelInput {}

protocol ListGenreMoviesViewModelType {
    var input: ListGenreMoviesViewModelInput { get }
    var output: ListGenreMoviesViewModelOutput { get }
}

final class ListGenreMoviesViewModel: BaseViewModel {
    private let showGenreListSubject = PassthroughSubject<[GenreViewModel], Never>()
    private let showDiscoverMoviesSubject = PassthroughSubject<Genre, Never>()
    
    private var genreList: [Genre]?
}

// MARK: ListGenreMoviesViewModelInput
extension ListGenreMoviesViewModel: ListGenreMoviesViewModelInput {
    func onViewDidLoad() {
        requestGenreList()
    }
}

// MARK: Private
private extension ListGenreMoviesViewModel {
    func requestGenreList() {
        showLoadingSubject.send(true)
        ListGenreMoviesServices().getListGenre { [weak self] result in
            self?.showLoadingSubject.send(false)
            switch result {
            case .success(let model):
                self?.genreList = model.genres
                let listViewModel = model.genres.map {
                    return GenreViewModel(
                        genre: $0,
                        tapCompletion: { [weak self] genre in
                            self?.showDiscoverMoviesSubject.send(genre)
                    })
                }
                self?.showGenreListSubject.send(listViewModel)
            case .failure(let error):
                self?.showAlertSubject.send(error.message)
            }
        }
    }
}

// MARK: ListGenreMoviesViewModelOutput
extension ListGenreMoviesViewModel: ListGenreMoviesViewModelOutput {
    var showGenreList: AnyPublisher<[GenreViewModel], Never> {
        return showGenreListSubject.eraseToAnyPublisher()
    }
    
    var showDiscoverMovies: AnyPublisher<Genre, Never> {
        return showDiscoverMoviesSubject.eraseToAnyPublisher()
    }
}

// MARK: ListGenreMoviesViewModelType
extension ListGenreMoviesViewModel: ListGenreMoviesViewModelType {
    var input: ListGenreMoviesViewModelInput {
        return self
    }
    var output: ListGenreMoviesViewModelOutput {
        return self
    }
}
