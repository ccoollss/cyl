//
//  NotificationCell.swift
//  Mabius
//
//  Created by spens on 08/07/16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import UIKit

protocol NotificationCellDelegate: class {
    func openProfile(with userId: Int)
}

class NotificationCell: UITableViewCell {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: TitleLabel!
    @IBOutlet weak var action: UILabel!
    @IBOutlet weak var point: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    weak var delegate: NotificationCellDelegate?

    var notification: Notifications.NotificationPoint? {
        didSet {
            user = notification?.notification.user
            
            if let notificationAction = notification?.notification.action, let act = NotificationAction(rawValue: notificationAction) {
                action.text = act.localizable(user?.gender)
                icon.image = act.icon
            }
            
            if let time = notification?.notification.timestamp { date.text = TimeInterval(time * 1000).timeAgo() }
            
            point.text = notification?.pointTitle
        }
    }

    var like: Like? {
        didSet {
            user = like?.user
            if let timestamp = like?.timestamp {
                date.text = TimeInterval(timestamp * 1000).timeAgo()
            }
        }
    }

    var user: User? {
        didSet {
            if let firstName = user?.name, let lastName = user?.secondName { name.text = firstName + " " + lastName }
            ImageFetcher.fetch(user?.avatarUrl, to: avatar, placeholder: #imageLiteral(resourceName: "imgProfile"))
        }
    }
    
    // MARK: - Object lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()

        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = avatar.bounds.size.height / 2
        avatar.backgroundColor = UIColor.cylMainColor()

        let view = UIView(frame: self.bounds)
        view.backgroundColor = UIColor.cylOffWhiteColor()
        self.selectedBackgroundView = view
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if !selected { return }
        setSelected(false, animated: true)
    }
    
    // MARK: - Actions

    @IBAction func showProfileButtonHandler(_ sender: AnyObject) {
        if let id = user?.id { delegate?.openProfile(with: id) }
    }
}
