//
//  ViewModelType.swift
//  {{cookiecutter.app_name}}
//
//
//  Copyright © 2019 {{cookiecutter.company_name}}. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}

class ViewModel: NSObject {

    let provider: API

    var page = 1

    let loading = ActivityIndicator()
    let headerLoading = ActivityIndicator()
    let footerLoading = ActivityIndicator()

    let error = ErrorTracker()

    init(provider: API) {
        self.provider = provider
        super.init()

        error.asDriver().drive(onNext: { (error) in
            logError("\(error)")
        }).disposed(by: rx.disposeBag)
    }

    deinit {
        logDebug("\(type(of: self)): Deinited")
    }
}
