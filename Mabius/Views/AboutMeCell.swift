//
//  AboutMeCell.swift
//  Mabius
//
//  Created by Timafei Harhun on 3/13/17.
//  Copyright © 2017 vice3.agency. All rights reserved.
//

import UIKit

protocol AboutMeCellOutput: class {
    func textViewDidEndEditing(_ text: String)
}

class AboutMeCell: UITableViewCell, UITextViewDelegate {

    @IBOutlet weak var aboutMeTextView: TextViewRxdisabled!
    
    var output: AboutMeCellOutput!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        aboutMeTextView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - UITextViewDelegate
    
    func textViewDidEndEditing(_ textView: UITextView) {
        output.textViewDidEndEditing(textView.text)
    }
}
