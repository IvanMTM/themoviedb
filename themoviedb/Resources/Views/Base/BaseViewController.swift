//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import UIKit
import Combine

class BaseViewController: UIViewController {
    var subscriptions = Set<AnyCancellable>()
    
    deinit {
        print("\(String(describing: type(of: self))) deinited")
    }
}
