//
//  Platform.swift
//
//  Created by Andrey Toropchin on 19.10.16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import Foundation
import UIKit

struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }()

    static let isPhone5_orLower: Bool = {
        return UIScreen.main.nativeBounds.height <= 1136
    }()

    static let isBackendEnabled: Bool = {
        return true
    }()
}
