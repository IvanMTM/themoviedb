//
// Created by OVO on 07/12/19.
// Copyright © 2019 OVO. All rights reserved.
//

public final class LoadingCellViewModel: ListDiffable {
    public var onDisplayCompletion: () -> Void
    
    public init(id: Int, onDisplayCompletion: @escaping () -> Void) {
        self.onDisplayCompletion = onDisplayCompletion
        super.init(id: id)
    }
}
