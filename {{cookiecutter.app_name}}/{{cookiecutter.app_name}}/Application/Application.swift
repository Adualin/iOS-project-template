//
//  Application.swift
//  {{cookiecutter.app_name}}
//
//  
//  Copyright © 2019 {{cookiecutter.company_name}}. All rights reserved.
//

import UIKit

class Application: NSObject {
    
    static let shared = Application()
    
    let navigator: Navigator
    let provider: API
    
    var window: UIWindow?
    
    override init() {
        navigator = Navigator.default
        provider = Api.shared
        super.init()
    }
    
    func presentInitialScreen(in window: UIWindow) {
        self.window = window
        navigator.show(segue: .main, sender: nil, transition: .root(in: window))
    }
}
