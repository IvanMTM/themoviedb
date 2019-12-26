//
// Created by OVO on 08/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import Combine

public protocol BaseViewModelOutput {
    var showTitle: AnyPublisher<String, Never> { get }
    var showLoading: AnyPublisher<Bool, Never> { get }
    var showAlert: AnyPublisher<String, Never> { get }
}

public protocol BaseViewModelInput {
    func onViewDidLoad()
}

open class BaseViewModel {
    public let showTitleSubject = PassthroughSubject<String, Never>()
    public let showLoadingSubject = PassthroughSubject<Bool, Never>()
    public let showAlertSubject = PassthroughSubject<String, Never>()
    
    public init() {}
}

// MARK: BaseViewModelOutput
extension BaseViewModel: BaseViewModelOutput {
    public var showTitle: AnyPublisher<String, Never> {
        return showTitleSubject.eraseToAnyPublisher()
    }
    
    public var showLoading: AnyPublisher<Bool, Never> {
        return showLoadingSubject.eraseToAnyPublisher()
    }
    
    public var showAlert: AnyPublisher<String, Never> {
        return showAlertSubject.eraseToAnyPublisher()
    }
}
