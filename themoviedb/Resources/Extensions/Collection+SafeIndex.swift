//
// Created by OVO on 07/12/19.
// Copyright © 2019 OVO. All rights reserved.
//

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
