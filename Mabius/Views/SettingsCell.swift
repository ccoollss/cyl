//
//  SettingsCell.swift
//  Mabius
//
//  Created by spens on 12/07/16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell
{

    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let view = UIView(frame: self.bounds)
        view.backgroundColor = UIColor.cylMainColor().withAlphaComponent(0.3)
        self.selectedBackgroundView = view
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
