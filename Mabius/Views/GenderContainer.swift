//
//  GenderContainer.swift
//  Mabius
//
//  Created by Andrey Toropchin on 21.07.16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import UIKit

enum Gender: String
{
    case male = "male"
    case female = "female"
}

class GenderContainer: UIView
{
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var maleCheckmark: UIImageView!
    @IBOutlet weak var femaleCheckmark: UIImageView!

    var gender = Gender.male

    override func awakeFromNib() {
        maleButton.addTarget(self, action: #selector(maleTap), for: .touchUpInside)
        femaleButton.addTarget(self, action: #selector(femaleTap), for: .touchUpInside)
        toggleCheckmarks()
    }

    @objc func maleTap() {
        gender = .male
        toggleCheckmarks()
    }

    @objc func femaleTap() {
        gender = .female
        toggleCheckmarks()
    }

    func toggleCheckmarks() {
        switch gender {
        case .male:
            maleCheckmark.isHidden = false
            femaleCheckmark.isHidden = true
        default:
            maleCheckmark.isHidden = true
            femaleCheckmark.isHidden = false
        }
    }
}
