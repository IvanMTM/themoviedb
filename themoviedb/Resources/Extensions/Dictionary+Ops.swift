//
// Created by OVO on 05/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

extension Dictionary {
    static func +(l: Dictionary, r: Dictionary?) -> Dictionary {
        guard let r = r else { return l }
        return r.reduce(l) {
            var nres = $0
            nres[$1.key] = $1.value
            return nres
        }
    }
}
