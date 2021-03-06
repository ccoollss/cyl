//
//  StepOneConfigurator.swift
//  Mabius
//
//  Created by Timafei Harhun on 2/24/17.
//  Copyright (c) 2017 vice3.agency. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

// MARK: - Connect View, Interactor, and Presenter

class Step1Configurator {
    
    // MARK: - Object lifecycle

    static let instance = Step1Configurator()

    private init() {}

    // MARK: - Configuration

    func configure(viewController: Step1ViewController) {
        
        let router = Step1Router(viewController: viewController)
        let presenter = Step1Presenter(output: viewController)
        let interactor = Step1Interactor(output: presenter)
        
        viewController.output = interactor
        viewController.router = router
    }
}
