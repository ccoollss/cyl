//
//  Button.swift
//  Mabius
//
//  Created by spens on 28/06/16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import UIKit

@IBDesignable class Button: UIButton
{
    @IBInspectable var filled: Bool = false {
        didSet {
            setup()
        }
    }
    
    fileprivate func setup()
    {
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        self.titleLabel?.font = UIFont.bigButtonFont()
        
        if filled
        {
            self.backgroundColor = UIColor.cylMainColor()
            self.setTitleColor(UIColor.white, for: UIControlState())
        }
        else
        {
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.cylMainColor().cgColor
            self.setTitleColor(UIColor.cylMainColor(), for: UIControlState())
        }
    }
    
    override var isEnabled: Bool
        {
        didSet {
            if isEnabled {
                self.backgroundColor = filled ? UIColor.cylMainColor() : UIColor.white
            } else {
                self.backgroundColor = UIColor.cylDisabledColor()
            }
        }
    }
}

@IBDesignable class CheckButton: UIButton
{
    @IBInspectable var margin: CGFloat = 0
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let divider = UIBezierPath(rect: CGRect(x: margin, y: self.frame.height - 0.5, width: self.frame.width - margin, height: 1))
        divider.lineWidth = 1 / UIScreen.main.scale
        UIColor(red: 200.0 / 255.0, green: 199.0 / 255.0, blue: 204.0 / 255.0, alpha: 1.0).setStroke()
        divider.stroke()
    }
}

@IBDesignable class RoundedButton: UIButton
{
    @IBInspectable var radius: CGFloat = 0
        {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var borderColor: UIColor?
        {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var sel: Bool = false
        {
        didSet {
            setup()
        }
    }

    func setup()
    {
        if radius > 0 {
            self.layer.cornerRadius = radius
        } else {
            self.layer.cornerRadius = 4
        }
        
        if borderColor != nil {
            if sel {
                self.layer.borderColor = UIColor.cylMainColor().cgColor
            } else {
                self.layer.borderColor = borderColor?.cgColor
            }
            self.layer.borderWidth = 2
        }
    }
    
    override func backgroundRect(forBounds bounds: CGRect) -> CGRect {
        if let bgImSize = backgroundImage(for: .normal)?.size { return fitToFillRect(CGRect.init(origin: bounds.origin, size: bgImSize), maxRect: bounds) }
        return bounds
    }
    
    func fitToFillRect(_ rect: CGRect, maxRect: CGRect) -> CGRect {
        
        let origRes = rect.size.width / rect.size.height;
        let newRes = maxRect.size.width / maxRect.size.height;
    
        var retRect = maxRect;
    
        if (newRes < origRes) {
            retRect.size.width = rect.size.width * maxRect.size.height / rect.size.height;
            retRect.origin.x = CGFloat(roundf(Float(CGFloat(maxRect.size.width - retRect.size.width) / CGFloat(2))));
        } else {
            retRect.size.height = rect.size.height * maxRect.size.width / rect.size.width;
            retRect.origin.y = CGFloat(roundf(Float(CGFloat(maxRect.size.height - retRect.size.height) / CGFloat(2))));
        }
        
        return retRect
    }
}

