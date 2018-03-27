//
//  CommentCell.swift
//  Mabius
//
//  Created by spens on 14/07/16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import UIKit

protocol CommentCellDelegate: class {
    func didSwipe(_ cell: CommentCell)
}

class CommentCell: UITableViewCell, ReuseId {
    
    @IBOutlet weak var author: TitleLabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    weak var delegate: CommentCellDelegate?
    
    var comment: Comment! {
        didSet {
            commentLabel.text = comment.text
            if let time = comment.timestamp {
                date.text = TimeInterval(time * 1000).timeAgo()
            }
        }
    }
    
    var user: User! {
        didSet {
            if let firstName = user.name, let lastName = user.secondName { author.text = "\(firstName) \(lastName)" }
            ImageFetcher.fetch(user.avatarUrl, to: avatar, placeholder: #imageLiteral(resourceName: "imgProfile"))
            avatar.clipsToBounds = true
            avatar.layer.cornerRadius = avatar.bounds.height / 2
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(CommentCell.swipeHandler))
        swipe.direction = .left
        self.addGestureRecognizer(swipe)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if !selected { return }
        setSelected(false, animated: true)
    }
    
    @objc func swipeHandler(){
        delegate?.didSwipe(self)
    }
}
