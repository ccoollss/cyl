//
//  LoginInteractor.swift
//  Mabius
//
//  Created by Andrey Toropchin on 14.02.17.
//  Copyright (c) 2017 vice3.agency. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import SwiftyUserDefaults

protocol LoginInteractorInput
{
    func checkInput(_ input: Login.Input.ViaEmail)
    func login(with input: Login.Input.ViaEmail)
    func loginViaFb()
    func loginViaVk()
}

class LoginInteractor: LoginInteractorInput, LoginWorkerOutput
{
    private let output: LoginPresenterInput
    private let worker: LoginWorker

    init(output: LoginPresenterInput) {
        self.output = output
        worker = LoginWorker()
        worker.output = self
    }

    // MARK: - Business logic

    func checkInput(_ input: Login.Input.ViaEmail)
    {
        output.handleInput(input.isValid)
    }

    func login(with input: Login.Input.ViaEmail)
    {
        output.beganLogin()
        worker.login(with: input)
    }

    func loginViaFb()
    {
        loginSocial(SocialType.facebook)
    }

    func loginViaVk()
    {
      //  loginSocial(SocialType.vkontakte)
    }

    // MARK: - Worker Output

    func didLogin(with output: Login.Output) {
        // Save token
        Defaults[.token] = output.token
        if let email = output.email { Defaults[.email] = email }
        
        // Load user
        worker.getUser(output.userId)
    }
    
    func gotUser(_ user: User) {
        // Save user
        Defaults[.userJSON] = user.toJSON()
        
        // Proceed next
        self.output.didLogin()
    }

    func gotError(_ error: Error) {
        output.gotError(error)
    }

    // MARK: - Private

    private func loginSocial(_ type: SocialType)
    {
        output.beganLogin()
        type.auth { profile, error in
            if let err = error { self.output.gotError(err) }
            else if let token = profile?.token {
                let input = Login.Input.ViaSocial(type: type.rawValue, token: token)
                self.worker.loginSocial(with: input)
            }
        }
    }
}
