//
// Created by OVO on 06/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import UIKit

final class LoadingCellViewModel: ListDiffable {
    var onDisplayCompletion: () -> Void
    
    init(id: Int, onDisplayCompletion: @escaping () -> Void) {
        self.onDisplayCompletion = onDisplayCompletion
        super.init(id: id)
    }
}

final class LoadingCell: UICollectionViewCell {}
