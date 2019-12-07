//
// Created by OVO on 07/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import UIKit

final class MovieReviewCell: UITableViewCell {
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
}

// MARK: Public
extension MovieReviewCell {
    func bind(viewModel: MovieReviewViewModel) {
        authorLabel.text = viewModel.author
        contentLabel.text = viewModel.content
    }
}
