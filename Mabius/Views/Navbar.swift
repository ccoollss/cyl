//
//  Navbar.swift
//  Mabius
//
//  Created by spens on 28/06/16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import UIKit

@IBDesignable class Navbar: UIView
{
    @IBInspectable var showDivider: Bool = true {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if showDivider {
            let divider = UIBezierPath(rect: CGRect(x: 0, y: self.frame.height - 0.5, width: self.frame.width, height: 1))
            divider.lineWidth = 1 / UIScreen.main.scale
            UIColor.black.withAlphaComponent(0.2).setStroke()
            divider.stroke()
        }
    }

    fileprivate var label: UILabel? {
        for view in subviews { if view is UILabel { return view as? UILabel } }
        return nil
    }

    var title: String {
        set { label?.text = newValue }
        get { return label?.text ?? "" }
    }
}
