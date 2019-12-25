//
// Created by OVO on 07/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import UIKit

final class DetailMovieInformationView: UIView {
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupView()
    }
}

// MARK: Public
extension DetailMovieInformationView {
    func bind(viewModel: DetailMovieInformationViewModel) {
        keyLabel.text = viewModel.key
        valueLabel.text = viewModel.value
    }
}

// MARK: Private
private extension DetailMovieInformationView {
    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
