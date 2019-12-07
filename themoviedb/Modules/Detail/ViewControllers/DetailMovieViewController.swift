//
// Created by OVO on 07/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import UIKit
import Combine

final class DetailMovieViewController: BaseViewController {
    @IBOutlet weak var stackView: UIStackView!
    private lazy var imagesView: DetailMovieImagesView = {
        let imagesView = UIView.createFromNib(DetailMovieImagesView.self)
        return imagesView
    }()
    private lazy var titleSubtitleView: DetailMovieTitleSubtitleView = {
        let titleSubtitleView = UIView.createFromNib(DetailMovieTitleSubtitleView.self)
        return titleSubtitleView
    }()
    private var informationViews = [DetailMovieInformationView]()
    
    var viewModel: DetailMovieViewModelType!
    var wireframe: DetailMovieWireframe!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
        viewModel.input.onViewDidLoad()
    }
}

// MARK: Private
private extension DetailMovieViewController {
    func setupView() {}
    
    func bindViewModel() {
        viewModel.output.showLoading.sink { [weak self] shouldShow in
            shouldShow ? self?.view.showLoadingView() : self?.view.hideLoadingView()
        }.store(in: &subscriptions)
        
        viewModel.output.showAlert.sink { [weak self] message in
            
        }.store(in: &subscriptions)
        
        viewModel.output.updateImageView.sink { [weak self] viewModel in
            guard let self = self else { return }
            self.imagesView.bind(viewModel: viewModel)
            self.stackView.insertArrangedSubview(self.imagesView, at: 0)
        }.store(in: &subscriptions)
        
        viewModel.output.updateTitleSubtitleView.sink { [weak self] viewModel in
            guard let self = self else { return }
            self.titleSubtitleView.bind(viewModel: viewModel)
            self.stackView.insertArrangedSubview(self.titleSubtitleView, at: 1)
        }.store(in: &subscriptions)
        
        viewModel.output.updateInformationViews.sink { [weak self] viewModels in
            guard let self = self else { return }
            viewModels.enumerated().forEach {
                let view = self.createInformationView(viewModel: $0.element)
                self.stackView.insertArrangedSubview(view, at: $0.offset + 2)
            }
        }.store(in: &subscriptions)
        
        viewModel.output.showReviews.sink { [weak self] movie in
            self?.wireframe.showReview(movie: movie)
        }.store(in: &subscriptions)
    }
    
    func createInformationView(viewModel: DetailMovieInformationViewModel) -> DetailMovieInformationView {
        let view = UIView.createFromNib(DetailMovieInformationView.self)
        view.bind(viewModel: viewModel)
        return view
    }
}
