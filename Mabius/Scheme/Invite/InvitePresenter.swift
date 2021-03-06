//
//  InvitePresenter.swift
//  Mabius
//
//  Created by Timafei Harhun on 15.02.17.
//  Copyright (c) 2017 vice3.agency. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

protocol InvitePresenterInput
{
    func beginInvitation()
    func didInvited()
    func gotError(_ error: Error)
    func handleInput(_ isValid: Bool)
}

protocol InvitePresenterOutput: class
{
    func didInvited()
    func showError(_ error: String)
    func toggleButton(_ isEnabled: Bool)
    func toggleView(_ isEnabled: Bool)
}

class InvitePresenter: InvitePresenterInput
{
    private weak var output: InvitePresenterOutput?

    init(output: InvitePresenterOutput)
    {
        self.output = output
    }

    func beginInvitation() {
        output?.toggleButton(false)
        output?.toggleView(false)
    }
    
    func didInvited() {
        output?.toggleButton(true)
        output?.toggleView(true)
        output?.didInvited()
    }
    
    func gotError(_ error: Error) {
        output?.toggleButton(true)
        output?.toggleView(true)
        output?.showError(String(describing: error))
    }
    
    func handleInput(_ isValid: Bool) {
        output?.toggleButton(isValid)
    }
}
