//
// Created by OVO on 08/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import Combine

protocol BaseViewModelOutput {
    var showTitle: AnyPublisher<String, Never> { get }
    var showLoading: AnyPublisher<Bool, Never> { get }
    var showAlert: AnyPublisher<String, Never> { get }
}

protocol BaseViewModelInput {
    func onViewDidLoad()
}

class BaseViewModel {
    let showTitleSubject = PassthroughSubject<String, Never>()
    let showLoadingSubject = PassthroughSubject<Bool, Never>()
    let showAlertSubject = PassthroughSubject<String, Never>()
}

// MARK: BaseViewModelOutput
extension BaseViewModel: BaseViewModelOutput {
    var showTitle: AnyPublisher<String, Never> {
        return showTitleSubject.eraseToAnyPublisher()
    }
    
    var showLoading: AnyPublisher<Bool, Never> {
        return showLoadingSubject.eraseToAnyPublisher()
    }
    
    var showAlert: AnyPublisher<String, Never> {
        return showAlertSubject.eraseToAnyPublisher()
    }
}
