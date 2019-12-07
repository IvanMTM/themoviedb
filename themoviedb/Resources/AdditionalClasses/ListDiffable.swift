//
// Created by OVO on 06/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

class ListDiffable {
    var id: Int
    
    init(id: Int) {
        self.id = id
    }
}

// MARK: Hashable
extension ListDiffable: Hashable {
    static func == (lhs: ListDiffable, rhs: ListDiffable) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
