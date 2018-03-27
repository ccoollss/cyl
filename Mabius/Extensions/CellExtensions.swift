//
//  CellExtensions.swift
//  Mabius
//
//  Created by Andrey Toropchin on 19.07.16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import UIKit

protocol ReuseId {
    var reuseIdentifier: String { get }
}

extension ReuseId where Self: UITableViewCell
{
    var reuseIdentifier: String { return String(describing: Self.self).components(separatedBy: ".").last! }
}

enum CellType: String
{
    case Title = "FeedDetailCell"
    case Images = "FeedDetailCellImages"
    case Description = "FeedDetailCellDescription"
    case Counters = "FeedDetailCellFavorites"
    case Comment = "CommentCell"
}

class CellContent
{
    var type: CellType!
    var point: Point!
    var comment: Comment!

    init(comment: Comment)
    {
        self.type = CellType.Comment
        self.comment = comment
    }

    init(type: CellType, point: Point)
    {
        self.type = type
        self.point = point
    }
}
