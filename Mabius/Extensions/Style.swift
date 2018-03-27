//
//  Style.swift
//  Mabius
//
//  Created by Andrey Toropchin on 13.05.16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import Foundation
import UIKit

extension UIColor
{
    class func cylMainColor() -> UIColor {
        return UIColor(red: 128.0 / 255.0, green: 206.0 / 255.0, blue: 202.0 / 255.0, alpha: 1.0)
    }
    class func cylMainDarkColor() -> UIColor {
        //return UIColor(red: 38.0 / 255.0, green: 73.0 / 255.0, blue: 71.0 / 255.0, alpha: 1.0)
        return UIColor(hexString: "#62BBB6")!
    }
    class func cylBlackColor() -> UIColor {
        return UIColor(white: 51.0 / 255.0, alpha: 1.0)
    }
    class func cylWhiteColor() -> UIColor {
        return UIColor(red: 246.0 / 255.0, green: 246.0 / 255.0, blue: 244.0 / 255.0, alpha: 1.0)
    }
    class func cylPurpleGreyColor() -> UIColor {
        return UIColor(red: 143.0 / 255.0, green: 142.0 / 255.0, blue: 148.0 / 255.0, alpha: 1.0)
    }
    class func cylPurplishGreyColor() -> UIColor {
        return UIColor(red: 122.0 / 255.0, green: 121.0 / 255.0, blue: 123.0 / 255.0, alpha: 1.0)
    }
    class func cylPaleTealColor() -> UIColor {
        return UIColor(red: 98.0 / 255.0, green: 187.0 / 255.0, blue: 182.0 / 255.0, alpha: 1.0)
    }
    class func cylPaleGreyColor() -> UIColor {
        return UIColor(red: 237.0 / 255.0, green: 240.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
    }
    class func cylSilverColor() -> UIColor {
        return UIColor(red: 199.0 / 255.0, green: 199.0 / 255.0, blue: 205.0 / 255.0, alpha: 1.0)
    }
    class func cylDisabledColor() -> UIColor {
        return UIColor(red: 199.0 / 255.0, green: 212.0 / 255.0, blue: 220.0 / 255.0, alpha: 1.0)
    }
    class func cylGreyishColor() -> UIColor {
        return UIColor(white: 178.0 / 255.0, alpha: 1.0)
    }
    class func cylWhite90Color() -> UIColor {
        return UIColor(white: 250.0 / 255.0, alpha: 0.9)
    }
    class func cylGunmetalColor() -> UIColor {
        return UIColor(red: 74.0 / 255.0, green: 85.0 / 255.0, blue: 89.0 / 255.0, alpha: 1.0)
    }
    class func cylOffWhiteColor() -> UIColor {
        return UIColor(red: 255.0 / 255.0, green: 251.0 / 255.0, blue: 234.0 / 255.0, alpha: 1.0)
    }
    class func cylRedColor() -> UIColor {
        return UIColor(red: 200.0 / 255.0, green: 36.0 / 255.0, blue: 42.0 / 255.0, alpha: 1.0)
    }
    convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        var formatted = hexString.replacingOccurrences(of: "0x", with: "")
        formatted = formatted.replacingOccurrences(of: "#", with: "")
        if let hex = Int(formatted, radix: 16) {
            let red = CGFloat(CGFloat((hex & 0xFF0000) >> 16)/255.0)
            let green = CGFloat(CGFloat((hex & 0x00FF00) >> 8)/255.0)
            let blue = CGFloat(CGFloat((hex & 0x0000FF) >> 0)/255.0)
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        } else {
            return nil
        }
    }
}

extension UIFont {
    class func navBarLabelFont() -> UIFont? {
        return UIFont(name: "ProximaNova-Semibold", size: 17.0)
    }
    class func bigButtonFont() -> UIFont? {
        return UIFont(name: "ProximaNova-Semibold", size: 17.0)
    }
    class func cylFeedTitleFont() -> UIFont? {
        return UIFont(name: "ProximaNova-Semibold", size: 21.0)
    }
    class func proximaNovaRegular(_ size:CGFloat) -> UIFont? {
        return UIFont(name: "ProximaNova", size: size)
    }
    class func proximaNovaLight(_ size:CGFloat) -> UIFont? {
        return UIFont(name: "ProximaNova-Light", size: size)
    }
    class func proximaNovaSemibold(_ size:CGFloat) -> UIFont? {
        return UIFont(name: "ProximaNova-Semibold", size: size)
    }
    class func proximaNovaBold(_ size:CGFloat) -> UIFont? {
        return UIFont(name: "ProximaNova-Bold", size: size)
    }
}

