//
//  NotificationsConfigurator.swift
//  Mabius
//
//  Created by Timafei Harhun on 3/13/17.
//  Copyright (c) 2017 vice3.agency. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

// MARK: - Connect View, Interactor, and Presenter

class NotificationsConfigurator {
    
    // MARK: - Object lifecycle

    static let instance = NotificationsConfigurator()

    private init() {}

    // MARK: - Configuration

    func configure(viewController: NotificationsViewController) {
        
        let router = NotificationsRouter(viewController: viewController)
        let presenter = NotificationsPresenter(output: viewController)
        let interactor = NotificationsInteractor(output: presenter)
        
        viewController.output = interactor
        viewController.router = router
    }
}
