//
//  ProfileCell.swift
//  Mabius
//
//  Created by spens on 17/07/16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import UIKit

protocol ProfileCellDelegate: NSObjectProtocol {
    func textTapped(_ cell: ProfileCell)
}

class ProfileCell: UITableViewCell {
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var info: UITextView!
    @IBOutlet weak var counterLabel: UILabel!
    
    weak var delegate: ProfileCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        info.addGestureRecognizer(tap)

        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = avatar.bounds.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var user: User? {
        didSet {
            if let name = user?.name, let lastName = user?.secondName { username.text = "\(name) \(lastName)" } else { username.text = nil }
            
            if let length = user?.about?.length, length > 100, let startIndex = user?.about?.startIndex, let index = user?.about?.index(startIndex, offsetBy: 80), let newText = user?.about?.substring(to: index) {
                info.text = newText + "..."
            } else if let length = user?.about?.length, length == 0 || user?.about == nil {
                info.text = "profileCell.noInformation".localize()
            } else {
                info.text = user?.about
            }

            ImageFetcher.fetch(user?.avatarUrl, to: avatar, placeholder: #imageLiteral(resourceName: "imgProfile"))
        }
    }
    
    @objc func tapped() {
        guard let length = user?.about?.length, length == 0 || user?.about == nil else {
            delegate?.textTapped(self)
            return
        }
    }
}
