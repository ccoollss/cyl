//
//  BorderedTableView.swift
//  Mabius
//
//  Created by Andrey Toropchin on 11.07.16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import UIKit

@IBDesignable class BorderedTableView: UITableView
{
    @IBInspectable var borderColor: UIColor = UIColor.gray {
        didSet { setup() }
    }

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    fileprivate func setup()
    {
        tableFooterView = UIView()

        layer.borderColor = borderColor.cgColor
        layer.cornerRadius = 1.0
        layer.borderWidth = 1.0 / UIScreen.main.scale
    }

    override func prepareForInterfaceBuilder() { setup() }
}
