//
//  EditProfileInteractor.swift
//  Mabius
//
//  Created by Timafei Harhun on 3/01/17.
//  Copyright (c) 2017 vice3.agency. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit
import SwiftyUserDefaults

protocol EditProfileInteractorInput {

    var input: EditProfile.Input { get set }

    func edit()
    
    func uploadImage(_ image: UIImage)
    func addSocial(_ type: SocialType)
    func pushUpdate(_ subcscribe: Bool)
    
    func logout()
}

class EditProfileInteractor: EditProfileInteractorInput, EditProfileWorkerOutput {

    private let output: EditProfilePresenterInput
    private let worker: EditProfileWorker

    var input: EditProfile.Input

    init(output: EditProfilePresenterInput) {

        if let user = User.fromDefaults {
            input = EditProfile.Input(userId: user.id,
                                      firstName: user.name,
                                      lastName: user.secondName,
                                      avatarUrl: user.avatarUrl,
                                      gender: user.sex == "male" ? Gender.male : Gender.female,
                                      about: user.about,
                                      email: user.email,
                                      tokens: user.socialTypes?.reduce([SocialType:SocialProfile]()) { result, string in
                                        let type = SocialType(rawValue: string)!
                                        var profile = SocialProfile.forType(type)
                                        if profile.name.length == 0 { profile.name = user.name }
                                        
                                        var result = result
                                        result[type] = profile
                                        return result
                                        } ?? [:],
                                      togglePushes: Defaults[.pushStatus],
                                      avatarId: nil)
        } else {
            input = EditProfile.Input(userId: 0, firstName: nil, lastName: nil, avatarUrl: nil, gender: Gender.male, about: nil, email: nil, tokens: [:], togglePushes: false, avatarId: nil)
        }

        self.output = output
        worker = EditProfileWorker()
        worker.output = self
    }

    // MARK: - Business logic

    func edit() {
        output.beginEditing()
        worker.edit(with: input)
    }
    
    func uploadImage(_ image: UIImage) {
        output.beginUpload()
        worker.uploadImage(image)
    }
    
    func addSocial(_ type: SocialType) {
        worker.addSocial(type)
    }
    
    func pushUpdate(_ subcscribe: Bool) {
        output.beginPushUpdate()
        worker.pushUpdate(subcscribe)
    }
    
    func logout() {
        output.beginLogout()
        //worker.pushUnsubscribe()
        worker.logout()
        Defaults.removeAll()
    }
    
    // MARK: - Worker Output

    func didEdited(with output: EditProfile.Output) {
        if let user = User.fromDefaults {
            worker.getUser(by: user.id)
        }
    }
    
    func didUploadImage(_ id: Int) {
        input.avatarId = id
        edit()
    }
    
    func didGetUser(_ user: User) {
        if let userFromDefaults = User.fromDefaults {
            userFromDefaults.name = user.name
            userFromDefaults.secondName = user.secondName
            userFromDefaults.about = user.about
            userFromDefaults.sex = user.sex
            userFromDefaults.avatarUrl = user.avatarUrl
            userFromDefaults.socialTypes = user.socialTypes
            userFromDefaults.saveToDefaults()

            input.avatarUrl = user.avatarUrl
            UsersDataStorage.save(user: user)
        }
        
        // Post notification
        NotificationCenter.default.post(name: profileEditedNotification, object: nil)
        
        self.output.didEdited()
    }
    
    func didAddSocial(_ type: SocialType, profile: SocialProfile) {
        input.tokens[type] = profile
        edit()
    }
    
    func didPushUpdate(_ subcscribe: Bool) {
        input.togglePushes = subcscribe
        Defaults[.pushStatus] = subcscribe
        output.didPushUpdate(subcscribe)
    }
    
    func didPushUnsubscribed() {
        worker.logout()
    }
    
    func didLogout() {
        output.didLogout()
    }
    
    func gotError(_ error: Error) {
        output.gotError(error)
    }
}

// Define identifier
let profileEditedNotification = Notification.Name("profileEditedNotification")
