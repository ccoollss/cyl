//
//  Defaults.swift
//  Mabius
//
//  Created by Andrey Toropchin on 19.05.16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import SwiftyUserDefaults

extension DefaultsKeys
{
    static let email = DefaultsKey<String>("email")
    static let token = DefaultsKey<String?>("token")
    
    static let userJSON = DefaultsKey<[String: Any]>("user")

    static let fbUsername = DefaultsKey<String?>("fbUsername")
    static let vkUsername = DefaultsKey<String?>("vkUsername")
    
    static let showModeration = DefaultsKey<Bool>("showModeration")
    static let hintsShown = DefaultsKey<Bool>("hintsShown")
    
    static let pushStatus = DefaultsKey<Bool>("pushStatus")
}
