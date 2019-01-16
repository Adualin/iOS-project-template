//
//  Navigator.swift
//  {{cookiecutter.app_name}}
//
//  Created by Cyan on 2019/1/16.
//  Copyright © 2019 {{cookiecutter.company_name}}. All rights reserved.
//

import Foundation
import UIKit
import SwifterSwift
import Hero

class Navigator {
    
    static var `default` = Navigator()
    
    enum Scene {
        
    }
    
    enum Transition {
        case root(in: UIWindow)
        case navigation(type: HeroDefaultAnimationType)
        case customModal(type: HeroDefaultAnimationType)
        case modal
        case detail
        case alert
        case custom
    }
    
    func get(segue: Scene) -> UIViewController? {
        return nil
    }
    
    func pop(sender: UIViewController?, toRoot: Bool = false) {
        if toRoot {
            sender?.navigationController?.popToRootViewController(animated: true)
        } else {
            sender?.navigationController?.popViewController()
        }
    }
    
    func dismiss(sender: UIViewController?) {
        sender?.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func injectTabBarControllers(in target: UITabBarController) {
        if let children = target.viewControllers {
            for vc in children {
                injectNavigator(in: vc)
            }
        }
    }
    
    // MARK: - invoke a single segue
    func show(segue: Scene, sender: UIViewController?, transition: Transition = .navigation(type: .cover(direction: .left))) {
        if let target = get(segue: segue) {
            show(target: target, sender: sender, transition: transition)
        }
    }
    
    private func show(target: UIViewController, sender: UIViewController?, transition: Transition) {
        injectNavigator(in: target)
        
        switch transition {
        case .root(in: let window):
            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                window.rootViewController = target
            }, completion: nil)
            return
        case .custom: return
        default: break
        }
        
        guard let sender = sender else {
            fatalError("You need to pass in a sender for .navigation or .modal transitions")
        }
        
        if let nav = sender as? UINavigationController {
            //push root controller on navigation stack
            nav.pushViewController(target, animated: false)
            return
        }
        
        switch transition {
        case .navigation(let type):
            if let nav = sender.navigationController {
                //add controller to navigation stack
                nav.hero.navigationAnimationType = .autoReverse(presenting: type)
                nav.pushViewController(target, animated: true)
            }
        case .customModal(let type):
            //present modally with custom animation
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: target)
                nav.hero.modalAnimationType = .autoReverse(presenting: type)
                sender.present(nav, animated: true, completion: nil)
            }
        case .modal:
            //present modally
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: target)
                sender.present(nav, animated: true, completion: nil)
            }
        case .detail:
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: target)
                sender.showDetailViewController(nav, sender: nil)
            }
        case .alert:
            DispatchQueue.main.async {
                sender.present(target, animated: true, completion: nil)
            }
        default: break
        }
    }
    
    private func injectNavigator(in target: UIViewController) {
        // view controller
        if var target = target as? Navigatable {
            target.navigator = self
            return
        }
        
        // navigation controller
        if let target = target as? UINavigationController, let root = target.viewControllers.first {
            injectNavigator(in: root)
        }
        
        // split controller
        if let target = target as? UISplitViewController, let root = target.viewControllers.first {
            injectNavigator(in: root)
        }
    }
}
