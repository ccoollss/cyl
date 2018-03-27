//
//  NotificationAction.swift
//  Mabius
//
//  Created by Andrey Toropchin on 13.07.16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import Foundation
import UIKit

enum NotificationAction: String
{
    case Like = "like"
    case Comment = "comment"
    case Reply = "reply"
    case Published = "published"
}

extension NotificationAction
{
    func localizable(_ gender: Gender?) -> String {
        let ending = gender == .female ? "" : ""
        return String(format: NSLocalizedString(self.rawValue, comment: ""), ending)
    }

    var icon: UIImage? {
        get {
            switch self {
            case .Comment:
                return UIImage(named: "icCommentsSmall")
            case .Like:
                return UIImage(named: "icStarSmall")
            case .Reply:
                return UIImage(named: "icCommentsSmall")
            case .Published:
                return nil
            }
        }
    }
}
