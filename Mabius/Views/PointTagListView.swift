//
//  PointTagListView.swift
//  Mabius
//
//  Created by spens on 17/07/16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import UIKit
import TagListView

class PointTagListView: TagListView
{
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    fileprivate func setup()
    {
        tagBackgroundColor = UIColor.cylPaleGreyColor()
        tagSelectedBackgroundColor = UIColor.cylMainColor()
        cornerRadius = 7
        textFont = UIFont.systemFont(ofSize: 12)
        textColor = UIColor.cylPurpleGreyColor()
        selectedTextColor = UIColor.white
        paddingY = 4.5
        paddingX = 8
    }
    
    override func prepareForInterfaceBuilder() {
        setup()
    }
}
