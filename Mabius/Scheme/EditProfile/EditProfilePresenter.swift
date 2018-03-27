//
//  EditProfilePresenter.swift
//  Mabius
//
//  Created by Timafei Harhun on 3/01/17.
//  Copyright (c) 2017 vice3.agency. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

protocol EditProfilePresenterInput {
    
    func beginEditing()
    func didEdited()
    
    func beginUpload()

    func beginPushUpdate()
    func didPushUpdate(_ subcscribe: Bool)
    
    func beginLogout()
    func didLogout()
    
    func gotError(_ error: Error)
}

protocol EditProfilePresenterOutput: class {
    
    func didEdited()
    func didPushUpdate(_ subcscribe: Bool)
    func didLogout()
    
    func showError(_ error: String)
    func toggleView(_ isEnabled: Bool)
}

class EditProfilePresenter: EditProfilePresenterInput {
    
    private weak var output: EditProfilePresenterOutput?

    init(output: EditProfilePresenterOutput) {
        self.output = output
    }

    // MARK: - Presentation logic
    
    func beginEditing() {
        beganActivity()
    }
    
    func didEdited() {
        endActivity()
        output?.didEdited()
    }
        
    func beginUpload() {
        beganActivity()
    }
    
    func beginPushUpdate() {
        beganActivity()
    }
    
    func didPushUpdate(_ subcscribe: Bool) {
        endActivity()
        output?.didPushUpdate(subcscribe)
    }
    
    func beginLogout() {
        beganActivity()
    }
    
    func didLogout() {
        endActivity()
        output?.didLogout()
    }
    
    func gotError(_ error: Error) {
        output?.toggleView(true)
        output?.showError(String(describing: error))
    }
    
    // MARK: Activity
    
    func beganActivity() {
        output?.toggleView(false)
    }
    
    func endActivity() {
        output?.toggleView(true)
    }
}