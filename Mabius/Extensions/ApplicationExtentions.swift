//
//  ApplicationExtentions.swift
//  Mabius
//
//  Created by Andrey Toropchin on 20.03.17.
//  Copyright © 2017 vice3.agency. All rights reserved.
//

import UIKit

extension UIApplication
{
    class func openUrl(_ string: String)
    {
        UIApplication.shared.openURL(URL(string: string)!)
    }
}
