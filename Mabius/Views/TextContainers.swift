//
//  TextField.swift
//  Mabius
//
//  Created by spens on 28/06/16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import UIKit
import KMPlaceholderTextView

@IBDesignable class TextField: UITextField
{
    @IBInspectable var filled: Bool = true {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var leftMargin: CGFloat =  8 {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var rightMargin: CGFloat =  8 {
        didSet {
            setup()
        }
    }

    func setup()
    {
        self.layer.cornerRadius = 4
        self.font = UIFont.systemFont(ofSize: 17)
        self.textColor = UIColor.cylBlackColor()
        self.clipsToBounds = true
        
        if filled
        {
            self.backgroundColor = UIColor.cylWhiteColor()
            self.layer.borderColor = UIColor.cylMainColor().withAlphaComponent(0.0).cgColor
        }
        else
        {
            self.backgroundColor = UIColor.white
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.cylMainColor().withAlphaComponent(0.5).cgColor
        }
    }

    func setupEx()
    {
        addTarget(self, action: #selector(toggle), for: .editingChanged)
    }

    @objc func toggle() {
        guard let text = self.text else { return }
        filled = text.length == 0
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupEx()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupEx()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: leftMargin, dy: rightMargin)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: leftMargin, dy: rightMargin)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: leftMargin, dy: rightMargin)
    }
}

@IBDesignable class TextFieldRxdisabled: UITextField
{
    @IBInspectable var filled: Bool = true {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var leftMargin: CGFloat =  8 {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var rightMargin: CGFloat =  8 {
        didSet {
            setup()
        }
    }
    
    func setup()
    {
        self.layer.cornerRadius = 4
        self.font = UIFont.systemFont(ofSize: 17)
        self.textColor = UIColor.cylBlackColor()
        self.clipsToBounds = true
        
        if filled
        {
            self.backgroundColor = UIColor.cylWhiteColor()
            self.layer.borderColor = UIColor.cylMainColor().withAlphaComponent(0.0).cgColor
        }
        else
        {
            self.backgroundColor = UIColor.white
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.cylMainColor().withAlphaComponent(0.5).cgColor
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: leftMargin, dy: rightMargin)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: leftMargin, dy: rightMargin)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: leftMargin, dy: rightMargin)
    }
}

@IBDesignable class TextViewRxdisabled: UITextView
{
    @IBInspectable var filled: Bool = true {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var fillColor: UIColor?
    
    fileprivate func setup()
    {
        self.textContainerInset = UIEdgeInsetsMake(10, 3, 10, 3)
        self.layer.cornerRadius = 4
        self.font = UIFont.systemFont(ofSize: 17)
        self.textColor = UIColor.cylBlackColor()
        self.clipsToBounds = true
        
        if filled
        {
            if fillColor != nil {
                self.backgroundColor = fillColor!
                self.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
            } else {
                self.backgroundColor = UIColor.cylWhiteColor()
                self.layer.borderColor = UIColor.cylMainColor().withAlphaComponent(0.0).cgColor
            }
        }
        else
        {
            self.backgroundColor = UIColor.white
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.cylMainColor().withAlphaComponent(0.5).cgColor
        }
    }
}

@IBDesignable class TextView: KMPlaceholderTextView
{
    @IBInspectable var filled: Bool = true {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var rxdisabled: Bool = false
    @IBInspectable var fillColor: UIColor?
    
    fileprivate func setup()
    {
        self.textContainerInset = UIEdgeInsetsMake(10, 3, 10, 3)
        self.layer.cornerRadius = 4
        self.font = UIFont.systemFont(ofSize: 17)
        self.textColor = UIColor.cylBlackColor()
        self.clipsToBounds = true
        
        if filled
        {
            if fillColor != nil {
                self.backgroundColor = fillColor!
                self.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
            } else {
                self.backgroundColor = UIColor.cylWhiteColor()
                self.layer.borderColor = UIColor.cylMainColor().withAlphaComponent(0.0).cgColor
            }
        }
        else
        {
            self.backgroundColor = UIColor.white
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.cylMainColor().withAlphaComponent(0.5).cgColor
        }
    }
}

@IBDesignable class TextViewDescription: UITextView
{
    override func awakeFromNib() {
        setup()
    }
    
    fileprivate func setup()
    {
        self.textContainerInset = UIEdgeInsetsMake(10, 3, 10, 3)
        self.layer.cornerRadius = 4
        self.font = UIFont.systemFont(ofSize: 17)
        self.textColor = UIColor.cylBlackColor()
        self.clipsToBounds = true
        self.backgroundColor = UIColor.white
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        self.layer.borderWidth = 1
    }
}
