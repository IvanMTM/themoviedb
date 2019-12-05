//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import Combine
import Foundation

protocol ListGenreMoviesViewModelOutput {
    var showLoading: AnyPublisher<Bool, Never> { get }
    var showGenreList: AnyPublisher<[GenreViewModel], Never> { get }
    var showAlert: AnyPublisher<String, Never> { get }
    var showDiscoverMovies: AnyPublisher<String, Never> { get }
}

protocol ListGenreMoviesViewModelInput {
    func onViewDidLoad()
}

protocol ListGenreMoviesViewModelType {
    var input: ListGenreMoviesViewModelInput { get }
    var output: ListGenreMoviesViewModelOutput { get }
}

final class ListGenreMoviesViewModel {
    private let showLoadingSubject = PassthroughSubject<Bool, Never>()
    private let showGenreListSubject = PassthroughSubject<[GenreViewModel], Never>()
    private let showAlertSubject = PassthroughSubject<String, Never>()
    private let showDiscoverMoviesSubject = PassthroughSubject<String, Never>()
    
    private var genreList: [GenreList.Genre]?
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
                        tapCompletion: { [weak self] viewModel in
                            self?.showDiscoverMoviesSubject.send(viewModel.id)
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
    var showLoading: AnyPublisher<Bool, Never> {
        return showLoadingSubject.eraseToAnyPublisher()
    }
    
    var showGenreList: AnyPublisher<[GenreViewModel], Never> {
        return showGenreListSubject.eraseToAnyPublisher()
    }
    
    var showAlert: AnyPublisher<String, Never> {
        return showAlertSubject.eraseToAnyPublisher()
    }
    
    var showDiscoverMovies: AnyPublisher<String, Never> {
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
