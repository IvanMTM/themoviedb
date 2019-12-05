//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import UIKit
import Combine

class BaseView: UIView {
    var subscriptions = Set<AnyCancellable>()
}
