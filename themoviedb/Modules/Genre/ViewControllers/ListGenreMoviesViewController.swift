//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import UIKit
import Combine

final class ListGenreMoviesViewController: BaseViewController {
    @IBOutlet weak var stackView: UIStackView!
    
    var viewModel: ListGenreMoviesViewModelType!
    var wireframe: ListGenreMoviesWireframe!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
        viewModel.input.onViewDidLoad()
    }
}

// MARK: Private
private extension ListGenreMoviesViewController {
    func setupView() {}
    
    func bindViewModel() {
        viewModel.output.showGenreList.sink { [weak self] genres in
            self?.setContentStackView(with: genres)
        }.store(in: &subscriptions)
        
        viewModel.output.showLoading.sink { [weak self] shouldShow in
            shouldShow ? self?.view.showLoadingView() : self?.view.hideLoadingView()
        }.store(in: &subscriptions)
        
        viewModel.output.showDiscoverMovies.sink { [weak self] genre in
            self?.wireframe.showDiscoverMoviesViewController(genre: genre)
        }.store(in: &subscriptions)
        
        viewModel.output.showAlert.sink { [weak self] genreId in
            
        }.store(in: &subscriptions)
    }
    
    func setContentStackView(with genreList: [GenreViewModel]) {
        stackView.subviews.forEach { $0.removeFromSuperview() }
        genreList.forEach {
            let genreView = UIView.createFromNib(GenreView.self)
            genreView.bind(viewModel: $0)
            stackView.addArrangedSubview(genreView)
        }
    }
}
