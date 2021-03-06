//
//  EditProfileConfigurator.swift
//  Mabius
//
//  Created by Timafei Harhun on 3/01/17.
//  Copyright (c) 2017 vice3.agency. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

// MARK: - Connect View, Interactor, and Presenter

class EditProfileConfigurator {
    
    // MARK: - Object lifecycle

    static let instance = EditProfileConfigurator()

    private init() {}

    // MARK: - Configuration

    func configure(viewController: EditProfileViewController) {
        let router = EditProfileRouter(viewController: viewController)
        let presenter = EditProfilePresenter(output: viewController)
        let interactor = EditProfileInteractor(output: presenter)
        
        viewController.output = interactor
        viewController.router = router
    }
}
