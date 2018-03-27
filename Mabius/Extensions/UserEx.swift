//
//  UserEx.swift
//  Mabius
//
//  Created by Andrey Toropchin on 24.03.17.
//  Copyright © 2017 vice3.agency. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

extension User {
    class var fromDefaults: User? {
        return User(JSON: Defaults[.userJSON])
    }

    func saveToDefaults() {
        Defaults[.userJSON] = self.toJSON()
    }
}
