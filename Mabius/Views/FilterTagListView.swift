//
//  FilterTagListView.swift
//  Mabius
//
//  Created by Andrey Toropchin on 07.07.16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import TagListView

@IBDesignable class FilterTagListView: TagListView
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
        tagBackgroundColor = UIColor.cylGunmetalColor()
        tagSelectedBackgroundColor = UIColor.cylMainColor()
        cornerRadius = 8
        textFont = UIFont.systemFont(ofSize: 14)
        textColor = UIColor.white
        paddingY = 5.5
        paddingX = 9.5
        marginX = 8
        marginY = 8
    }

    override func prepareForInterfaceBuilder() {
        setup()
    }
}

import ObjectiveC

extension TagView {
    fileprivate struct AssociatedKeys {
        static var item = "item"
    }

    var item: AnyObject {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.item) as AnyObject
        }

        set {
            objc_setAssociatedObject(self, &AssociatedKeys.item, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
