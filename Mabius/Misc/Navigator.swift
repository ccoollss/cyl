//
//  Navigator.swift
//  Mabius
//
//  Created by Andrey Toropchin on 05.07.16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

enum PresentationPolicy
{
    case push
    case modal
    case root
}

enum StackPolicy
{
    case `default`
    case replaceLast
    case clearStack
}

protocol Navigation
{
    var presentationPolicy: PresentationPolicy { get }
    var stackPolicy: StackPolicy { get }
    func prepareWithParams(_ params: [String: String])
}

class Navigator
{
    class func openUrl(_ url: URL)
    {
        let identifier = aliases[url.host!] ?? url.host!

        // MARK: temp workaround
        if identifier == "Logout"
        {
            AppDelegate.instance.window?.rootViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController()
            return
        }

        var nc = AppDelegate.instance.window!.rootViewController! as? UINavigationController
        if nc == nil
        {
            guard let containerVc = AppDelegate.instance.window!.rootViewController! as? ContainerViewController else { return }
            guard let tabController = containerVc.contentViewController as? UITabBarController else { return }
            guard let selectedNc = tabController.selectedViewController as? UINavigationController else { return }
            nc = selectedNc
        }
        guard let navController = nc else { return }

        // Back case
        if identifier == "root"
        {
            _ = navController.popToRootViewController(animated: true)
            return
        }
        else if identifier == "back"
        {
            _ = navController.popViewController(animated: true)
            return
        }

        // Normal case
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
        guard let customVc = vc as? Navigation else { return }

        let query = url.query ?? ""
        var params = [String: String]()
        for str in query.components(separatedBy: "&") {
            params[str.components(separatedBy: "=").first!] = str.components(separatedBy: "=").last!.removingPercentEncoding
        }
        customVc.prepareWithParams(params)

        if customVc.presentationPolicy == .root {
            AppDelegate.instance.window?.rootViewController = vc
        }
        else
        {
            if customVc.presentationPolicy == .push { navController.pushViewController(vc, animated: true) }
            else { navController.present(vc, animated: true, completion: nil) }
        }

        if customVc.stackPolicy != .default
        {
            after(seconds: 1) {
                if customVc.stackPolicy == .replaceLast { navController.viewControllers.remove(at: navController.viewControllers.count - 2) }
                else { navController.viewControllers = [navController.viewControllers.first!, navController.viewControllers.last!] }
            }
        }
    }

    fileprivate class var aliases: [String: String] {
        get {
            return ["reg": "RegisterViewController",
                    "logout": "Logout",
                    "root": "root",
                    "back": "back"
            ]
        }
    }
}
