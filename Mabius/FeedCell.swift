//
//  FeedCell.swift
//  Mabius
//
//  Created by spens on 04/07/16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import UIKit
import TagListView
import ImageLoader

protocol FeedCellDelegate: NSObjectProtocol {
    func toggleLikeFor(point: Point)
    func openLikes(pointId: Int)
    func openComments(pointId: Int)
}

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var colorLine: UIView!
    @IBOutlet weak var title: FeedTitleLabel!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var projectImage: UIImageView!
    @IBOutlet weak var tagView: PointTagListView!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var favoritesCount: UILabel!
    @IBOutlet weak var commentsButton: UIButton!
    @IBOutlet weak var commentsCount: UILabel!

    @IBOutlet weak var openLikesButton: UIButton!
    @IBOutlet weak var openCommentsButton: UIButton!
    
    weak var delegate: FeedCellDelegate?

    var point: Point! {
        didSet {
            title.text = point.title
            commentsCount.text = String(point.comments!)
            favoritesCount.text = String(point.likes!)
            starButton.isSelected = point.isLiked!
            
            if let proj = point.project, let type = point.type {
                logo.image = getLogoFor(project: proj)
                info.text = type
            }

            title.text = point.title
            
            if let imgs = point.images, imgs.count > 0 {
//// FiXME: mock url
//                let testUrl = "https://www.google.co.jp/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png"
                projectImage.load.request(with: imgs[0], onCompletion: { _, error, _ in
                    
                })
            } else {
                projectImage.image = nil
            }
        }
    }
    
    var tags: [String] = [] {
        didSet {
            tagView.removeAllTags()
            for tag in tags { tagView.addTag(tag) }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        container.layer.cornerRadius = 4;
    }

    func getLogoFor(project: String) -> UIImage? {
        switch project {
        case "mabius":
            return #imageLiteral(resourceName: "imgMabius")
        case "enactus":
            return #imageLiteral(resourceName: "imgInactus")
        default:
            return nil
        }
    }
    
    @IBAction func favoriteButtonHandler() {
         delegate?.toggleLikeFor(point: point)
    }

    @IBAction func openLikes() {
        if point.likes! > 0 { delegate?.openLikes(pointId: point.id!) }
    }
    
    @IBAction func commentsButtonHandler(_ sender: AnyObject) {
        if point.comments! > 0 { delegate?.openComments(pointId: point.id!) }
    }
}
