//
//  TimeIntervalExtension.swift
//  Mabius
//
//  Created by spens on 11/07/16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import Foundation

extension TimeInterval
{
    func timeAgo() -> String
    {
        let interval = self / 1000
        let eventDate = NSDate(timeIntervalSince1970: interval)
        
        let elapsed = NSDate().timeIntervalSince1970 - interval
        let secondsElapsed = Int(elapsed)
        let minutesElapsed = Int(elapsed/60)
        let hoursElapsed = Int(minutesElapsed/60)
        let daysElapsed = Int(hoursElapsed/24)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        if daysElapsed > 2 {
            return dateFormatter.string(from: eventDate as Date)
        } else if daysElapsed == 1 {
            return "Date.yesterday".localize()
        }
        
        if hoursElapsed >= 1 {
            return "\(Int(hoursElapsed).declesion(["Date.hour0".localize(), "Date.hour1".localize(), "Date.hour2".localize()])!)" + "Date.ago".localize()
        } else if minutesElapsed >= 1 {
            return "\(Int(minutesElapsed).declesion(["Date.minute0".localize(), "Date.minute1".localize(), "minute2".localize()])!)" + "Date.ago".localize()
        } else if secondsElapsed < 10 {
            return "Date.now".localize()
        } else {
            return "\(Int(secondsElapsed).declesion(["Date.second0".localize(), "Date.second1".localize(), "Date.second2".localize()])!)" + "Date.ago".localize()
        }
    }
    
    func day() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        let date = Date(timeIntervalSince1970: self)
        return dateFormatter.string(from: date)
    }
}

extension Int
{
    func declesion(_ words: [String]) -> String?
    {
        var n = self < 0 ? (self * -1) : self
        n %= 100
        if n >= 5 && n <= 20 {
            return "\(self) \(words.last!)"
        }
        n %= 10
        if n == 1 {
            return "\(self) \(words.first!)"
        }
        if n >= 2 && n <= 4 {
            if words.count > 2 {
                return "\(self) \(words[1])"
            } else {
                return ""
            }
        }
        return "\(self) \(words.last!)"
    }
}
