//
//  NSDateExtensions.swift
//  Mabius
//
//  Created by Andrey Toropchin on 11.07.16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import Foundation

extension Date
{
    static var timestamp: Int { get { return Int(Date().timeIntervalSince1970 * 1000) } }
    
     func toString() -> String {
        let df = DateFormatter()
        df.dateFormat = "dd MMM yyyy, HH:mm"
        
        return df.string(from: self)
    }
    
    func toInt() -> Int {
        return Int(self.timeIntervalSince1970 * 1000)
    }
}
