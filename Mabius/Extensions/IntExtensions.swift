//
//  IntExtensions.swift
//  Mabius
//
//  Created by Andrey Toropchin on 11.07.16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import Foundation

extension Int
{
    var minutes: Int { return self * 60 }
    var hours: Int { return minutes * 60 }
    var days: Int { return hours * 24 }

    var unixtime: Int { return self * 1000 }
}
