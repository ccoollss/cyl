//
//  FeedCell.swift
//  Mabius
//
//  Created by Timafei Harhun on 04/03/17.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import UIKit
import TagListView

protocol FeedCellDelegate: NSObjectProtocol {
    func openPoint(_ point: Point)
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
    
    weak var delegate: FeedCellDelegate?
    
    var point: Point! {
        didSet {
            
            title.text = point.title
            if let comments = point.comments { commentsCount.text = String(comments) }
            if let likes = point.likes { favoritesCount.text = String(likes) }
            if let isLiked = point.isLiked { starButton.isSelected = isLiked }
            
            title.text = point.title
            projectImage.clipsToBounds = true
            projectImage.contentMode = .scaleAspectFill

            ImageFetcher.fetch(point.image, to: projectImage)
            
            setTags()
        }
    }
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        container.layer.cornerRadius = 4;
        
        let cellTapGR = UITapGestureRecognizer(target: self, action: #selector(onCellTapHandler))
        cellTapGR.numberOfTapsRequired = 1
        
        let doubleTapGR = UITapGestureRecognizer(target: self, action: #selector(onImageViewDoubleTapHandler))
        doubleTapGR.numberOfTapsRequired = 2
        
        self.addGestureRecognizer(cellTapGR)
        projectImage.addGestureRecognizer(doubleTapGR)
        
        cellTapGR.require(toFail: doubleTapGR)
    }
    
    // MARK: Configuration
    
    fileprivate func setTags() {
        tagView.removeAllTags()
        
        if let subIds = point.subCategories {
            let subCategories = CategoriesProvider.instance.getSubcategories(by: subIds)
            for subCategory in subCategories.prefix(2) { tagView.addTag(subCategory.title == nil ? "" : subCategory.title!) }
            if subCategories.count > 2 { tagView.addTag("Еще \(subCategories.count - 2)") }
        }
    }
    
    // MARK: Actions
    
    @IBAction func favoriteButtonHandler() {
        delegate?.toggleLikeFor(point: point)
    }
    
    @IBAction func openLikes() {
        if let likes = point.likes, likes > 0, let id = point.id {
            delegate?.openLikes(pointId: id)
        }
    }
    
    @IBAction func commentsButtonHandler(_ sender: AnyObject) {
        if let comments = point.comments, comments > 0, let id = point.id {
            delegate?.openComments(pointId: id)
        }
    }
    
    @objc func onImageViewDoubleTapHandler() {
        delegate?.toggleLikeFor(point: point)
    }
    
    @objc func onCellTapHandler() {
        delegate?.openPoint(point)
    }
}
