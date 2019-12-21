//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import UIKit
import Combine

open class BaseViewController: UIViewController {
    public var subscriptions = Set<AnyCancellable>()
    
    public init() {
        let classType = type(of: self)
        let bundle = Bundle(for: classType)
        super.init(nibName: String(describing: classType), bundle: bundle)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    deinit {
        print("\(String(describing: type(of: self))) deinited")
    }
}
