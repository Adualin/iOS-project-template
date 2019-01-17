//
//  API.swift
//  {{cookiecutter.app_name}}
//
//
//  Copyright © 2019 {{cookiecutter.company_name}}. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ObjectMapper
import Moya
import Moya_ObjectMapper


enum ApiError: Error {
    case serverError(title: String, description: String)
}

protocol API {
    
}


class Api: API {
    static let shared = Api()
}
