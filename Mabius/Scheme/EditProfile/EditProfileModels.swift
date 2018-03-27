//
//  EditProfileModels.swift
//  Mabius
//
//  Created by Timafei Harhun on 3/01/17.
//  Copyright (c) 2017 vice3.agency. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

struct EditProfile {
    
    struct Input {
        var userId: Int
        
        var firstName: String?
        var lastName: String?
        var avatarUrl: String?
        var gender: Gender?
        var about: String?
        
        var email: String?
        
        var tokens = [SocialType : SocialProfile]()
        
        var togglePushes: Bool!
        
        var avatarId: Int?
    }

    struct Output {
        
    }

    struct ViewModel {
        
    }
}