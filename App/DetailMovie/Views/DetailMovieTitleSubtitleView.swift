//
// Created by OVO on 07/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import UIKit

final class DetailMovieTitleSubtitleView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupView()
    }
}

// MARK: Public
extension DetailMovieTitleSubtitleView {
    func bind(viewModel: DetailMovieTitleSubtitleViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
    }
}

// MARK: Private
private extension DetailMovieTitleSubtitleView {
    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}

