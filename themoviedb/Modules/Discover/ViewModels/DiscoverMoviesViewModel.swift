//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import Foundation
import Combine

protocol DiscoverMoviesViewModelOutput {
    
}

protocol DiscoverMoviesViewModelInput {
    func onViewDidLoad()
}

protocol DiscoverMoviesViewModelType {
    var input: DiscoverMoviesViewModelInput { get }
    var output: DiscoverMoviesViewModelOutput { get }
}

final class DiscoverMoviesViewModel {
    private let genreId: String
    private var page = 1
    private let perPage = 20
    
    private var movies = [DiscoverMovieList.Result]()
    
    init(genreId: String) {
        self.genreId = genreId
    }
}

// MARK: Private
private extension DiscoverMoviesViewModel {
    func requestMovies() {
        DiscoverMoviesServices().getMoviesBy(genre: genreId, page: page) { [weak self] result in
            switch result {
            case .success(let model):
                self?.movies = model.results
                self?.page = model.page + 1
                
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
    }
}

// MARK: DiscoverMoviesViewModelOutput
extension DiscoverMoviesViewModel: DiscoverMoviesViewModelOutput {
    
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
