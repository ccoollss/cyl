//
//  LoginPresenter.swift
//  Mabius
//
//  Created by Andrey Toropchin on 14.02.17.
//  Copyright (c) 2017 vice3.agency. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

protocol LoginPresenterInput
{
    func beganLogin()
    func didLogin()
    func gotError(_ error: Error)
    func handleInput(_ isValid: Bool)
}

protocol LoginPresenterOutput: class
{
    func didLogin()
    func showError(_ error: String)
    func toggleButton(_ isEnabled: Bool)
    func toggleView(_ isEnabled: Bool)
}

class LoginPresenter: LoginPresenterInput
{
    private weak var output: LoginPresenterOutput?

    init(output: LoginPresenterOutput)
    {
        self.output = output
    }

    func didLogin()
    {
        output?.toggleButton(true)
        output?.toggleView(true)
        output?.didLogin()
    }

    func gotError(_ error: Error)
    {
        output?.toggleButton(true)
        output?.toggleView(true)
        output?.showError(String(describing: error))
    }

    func beganLogin() {
        output?.toggleButton(false)
        output?.toggleView(false)
    }

    func handleInput(_ isValid: Bool) {
        output?.toggleButton(isValid)
    }
}
