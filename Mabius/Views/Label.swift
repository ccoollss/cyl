//
//  Label.swift
//  Mabius
//
//  Created by spens on 28/06/16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import UIKit

@IBDesignable class CustomLabel: UILabel
{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {}
    override func prepareForInterfaceBuilder() { setup() }
}

@IBDesignable class NavbarLabel: CustomLabel
{
    override func setup()
    {
        font = UIFont.navBarLabelFont()
        textColor = UIColor.cylBlackColor()
    }
}

@IBDesignable class NormalLabel: CustomLabel
{
    override func setup()
    {
        font = UIFont.systemFont(ofSize: 14)
        textColor = UIColor.cylBlackColor()
    }
}

@IBDesignable class TitleLabel: CustomLabel
{
    override func setup()
    {
        font = UIFont.proximaNovaRegular(17)
        textColor = UIColor.cylBlackColor()
    }
}

@IBDesignable class FeedTitleLabel: CustomLabel
{
    override func setup()
    {
        font = UIFont.cylFeedTitleFont()
        textColor = UIColor.cylBlackColor()
    }
}

@IBDesignable class InfoLabel: CustomLabel
{
    override func setup()
    {
        font = UIFont.systemFont(ofSize: 12)
        textColor = UIColor.cylPurpleGreyColor()
    }
}
