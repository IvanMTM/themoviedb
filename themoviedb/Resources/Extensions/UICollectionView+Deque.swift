//
// Created by OVO on 06/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import UIKit

extension UICollectionView {
    func registerNib<T: UICollectionViewCell>(_: T.Type) {
        let nib = UINib(nibName: T.reuseIdentifier, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerClass<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("cannot deque \(T.reuseIdentifier) in CollectionView")
        }
        return cell
    }
}
