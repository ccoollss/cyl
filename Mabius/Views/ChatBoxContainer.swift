//
//  СhatBoxContainer.swift
//  Mabius
//
//  Created by Andrey Toropchin on 19.07.16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import UIKit

class СhatBoxContainer: UIView
{
    @IBOutlet weak var chatBox: UITextView!

    override func awakeFromNib()
    {
        super.awakeFromNib()

        layer.borderWidth = 1 / UIScreen.main.scale
        layer.borderColor = UIColor.cylPurpleGreyColor().cgColor

        chatBox.textContainerInset = UIEdgeInsetsMake(10, 0, 10, 0)
        chatBox.layer.cornerRadius = 4
        chatBox.clipsToBounds = true

        chatBox.layer.borderWidth = 1 / UIScreen.main.scale
        chatBox.layer.borderColor = UIColor.cylPurpleGreyColor().cgColor
    }
}
