//
//  StringEx.swift
//  Mabius
//
//  Created by Andrey Toropchin on 21.03.17.
//  Copyright © 2017 vice3.agency. All rights reserved.
//

import Foundation

extension String {
    var length: Int {
        return characters.count
    }

    func toInt() -> Int? {
        if let num = NumberFormatter().number(from: self) {
            return num.intValue
        } else {
            return nil
        }
    }

    func toBool() -> Bool? {
        let s = lowercased()
        if s.range(of: "true") != nil || s.range(of: "false") != nil {
            return (s as NSString).boolValue
        }
        return nil
    }

    var isEmail: Bool {
        let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let firstMatch = dataDetector?.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSRange(location: 0, length: length))
        return (firstMatch?.range.location != NSNotFound && firstMatch?.url?.scheme == "mailto")
    }
}
