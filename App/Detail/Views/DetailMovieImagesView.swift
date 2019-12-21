//
// Created by OVO on 07/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import UIKit
import Combine
import Ui_Kit

final class DetailMovieImagesView: BaseView {
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var backdropAlphaView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var reviewsButton: UIButton!
    @IBOutlet weak var trailersButton: UIButton!
    
    private var viewModel: DetailMovieImagesViewModel!
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupView()
        bindEvents()
    }
}

// MARK: Public
extension DetailMovieImagesView {
    func bind(viewModel: DetailMovieImagesViewModel) {
        self.viewModel = viewModel
        backdropImageView.sd_setImage(with: viewModel.backdropUrl)
        backdropAlphaView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        posterImageView.sd_setImage(with: viewModel.posterUrl)
    }
}

// MARK: Private
private extension DetailMovieImagesView {
    func setupView() {
        setConstraints()
    }
    
    func setConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.4).isActive = true
    }
    
    func bindEvents() {
        reviewsButton.publisher(for: .touchUpInside).sink { [weak self] _ in
            self?.viewModel?.reviewTapCompletion()
        }.store(in: &subscriptions)
        
        trailersButton.publisher(for: .touchUpInside).sink { [weak self] _ in
            self?.viewModel?.trailersTapCompletion()
        }.store(in: &subscriptions)
    }
}
