//
//  View.swift
//  Mabius
//
//  Created by spens on 19/07/16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import UIKit

@IBDesignable class RoundedView: UIView
{
    @IBInspectable var radius: CGFloat = 0
    {
        didSet {
            setupView()
        }
    }

    @IBInspectable var selected: Bool = false
        {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var borderColor: UIColor?
    {
        didSet {
            setupView()
        }
    }
    
    func setupView()
    {
        if radius > 0 {
            self.layer.cornerRadius = radius
        }
        if borderColor != nil {
            self.layer.borderColor = borderColor?.cgColor
            self.layer.borderWidth = 2
        }
        if selected {
            self.layer.borderColor = UIColor.cylMainColor().cgColor
        }
    }

}

class HintView: UIView
{

}
