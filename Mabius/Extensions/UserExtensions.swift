//
//  UserExtensions.swift
//  Mabius
//
//  Created by Andrey Toropchin on 13.07.16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import Foundation

extension User
{
    var gender: Gender {
        get {
            return Gender(rawValue: sex)!
        }
    }

    var fullname: String {
        get {
            return "\(name) \(secondName)"
        }
    }
}
