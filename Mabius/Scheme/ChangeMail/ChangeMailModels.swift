//
//  ChangeMailModels.swift
//  Mabius
//
//  Created by Timafei Harhun on 2/21/17.
//  Copyright (c) 2017 vice3.agency. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

struct ChangeMail {
    
    struct Input {
        let email: String?
        let password: String?
    }

    struct Output {
    }

    struct ViewModel {
    }
}

extension ChangeMail.Input {
    
    var isValid: Bool {
        guard let email = email else { return false }
        guard let password = password else { return false }
        return email.isEmail && password.length >= minPasswordLength
    }
}
