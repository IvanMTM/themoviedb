//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import UIKit
import Combine

final class GenreView: BaseView {
    @IBOutlet weak var button: UIButton!
    
    private var viewModel: GenreViewModel?
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        bindEvents()
    }
}

// MARK: Public
extension GenreView {
    func bind(viewModel: GenreViewModel) {
        self.viewModel = viewModel
        button.setTitle(viewModel.title, for: .normal)
    }
}

// MARK: Private
private extension GenreView {
    func bindEvents() {
        button.publisher(for: .touchUpInside).sink { [weak self] _ in
            guard let viewModel = self?.viewModel else {
                return
            }
            viewModel.tapCompletion(viewModel)
        }.store(in: &subscriptions)
    }
}
