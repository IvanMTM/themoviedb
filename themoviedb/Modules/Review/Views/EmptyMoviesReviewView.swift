//
// Created by OVO on 07/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import UIKit

final class EmptyMoviesReviewView: UIView {
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupView()
    }
}

// MARK: Private
private extension EmptyMoviesReviewView {
    func setupView() {
        setConstraints()
    }
    
    func setConstraints() {
        guard let superview = superview else {
            return
        }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftAnchor.constraint(equalTo: superview.leftAnchor),
            rightAnchor.constraint(equalTo: superview.rightAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            topAnchor.constraint(equalTo: superview.topAnchor)
        ])
    }
}
