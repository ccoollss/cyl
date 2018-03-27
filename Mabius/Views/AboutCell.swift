//
//  AboutCell.swift
//  Mabius
//
//  Created by Andrey Toropchin on 11.07.16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import UIKit

class AboutCell: UITableViewCell
{
    @IBOutlet weak var title: UILabel!

    var infoCategory: InfoCategory? {
        didSet { title.text = infoCategory?.title }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if !selected { return }
        setSelected(false, animated: true)
    }
}
