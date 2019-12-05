//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import Combine
import Foundation

protocol ListGenreMoviesViewModelOutput {
    var showLoading: AnyPublisher<Bool, Never> { get }
    var showGenreList: AnyPublisher<[GenreViewModel], Never> { get }
}

protocol ListGenreMoviesViewModelInput {
    func onViewDidLoad()
}

protocol ListGenreMoviesViewModelType {
    var input: ListGenreMoviesViewModelInput { get }
    var output: ListGenreMoviesViewModelOutput { get }
}

final class ListGenreMoviesViewModel {
    private var showLoadingSubject = PassthroughSubject<Bool, Never>()
    private var showGenreListSubject = PassthroughSubject<[GenreViewModel], Never>()
    
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
                            
                    })
                }
                self?.showGenreListSubject.send(listViewModel)
            case .failure(let error):
                break
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
