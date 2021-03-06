//
//  LoginConfigurator.swift
//  Mabius
//
//  Created by Andrey Toropchin on 14.02.17.
//  Copyright (c) 2017 vice3.agency. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

// MARK: - Connect View, Interactor, and Presenter

class LoginConfigurator
{
    // MARK: - Object lifecycle

    static let instance = LoginConfigurator()

    private init() {}

    // MARK: - Configuration

    func configure(viewController: LoginViewController)
    {
        let router = LoginRouter(viewController: viewController)
        let presenter = LoginPresenter(output: viewController)
        let interactor = LoginInteractor(output: presenter)

        viewController.output = interactor
        viewController.router = router
    }
}
