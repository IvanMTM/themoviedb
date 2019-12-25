//
// Created by OVO on 06/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import UIKit
import SDWebImage

final class DiscoverMovieCell: UICollectionViewCell {
    @IBOutlet weak var backImageView: UIImageView!
}

// MARK: Public
extension DiscoverMovieCell {
    func bind(viewModel: DiscoverMovieViewModel) {
        backImageView?.sd_setImage(with: viewModel.urlImage)
    }
}
