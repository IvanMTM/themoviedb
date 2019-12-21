//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import UIKit

public extension UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        let bundle = Bundle(for: self)
        return UINib(nibName: reuseIdentifier, bundle: bundle)
    }
    
    static func createFromNib<T: UIView>(_ type: T.Type) -> T {
        guard let view = type.nib.instantiate(withOwner: nil, options: nil).first as? T else {
            fatalError("cannot create \(reuseIdentifier) from XIB")
        }
        return view
    }
}

public extension UITableView {
    func registerNib<T: UITableViewCell>(_: T.Type) {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.reuseIdentifier, bundle: bundle)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerClass<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerHeaderFooter<T: UIView>(_: T.Type) {
        register(T.nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueClass<T: UITableViewCell>(_ class: T.Type) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("cannot deque \(T.reuseIdentifier) in TableView")
        }
        return cell
    }
    
    func dequeueCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("cannot deque \(T.reuseIdentifier) in TableView")
        }
        return cell
    }
    
    func dequeHeaderFooter<T: UIView>(_ class: T.Type) -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("cannot deque \(T.reuseIdentifier) in TableView")
        }
        return view
    }
}
