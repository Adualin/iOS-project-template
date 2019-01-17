//
//  SplitViewController.swift
//  {{cookiecutter.app_name}}
//
//
//  Copyright © 2019 {{cookiecutter.company_name}}. All rights reserved.
//

import UIKit

class SplitViewController: UISplitViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        delegate = self
        preferredDisplayMode = .allVisible
    }
}

extension SplitViewController: UISplitViewControllerDelegate {

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
