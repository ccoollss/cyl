//
//  Step3Cell.swift
//  Mabius
//
//  Created by spens on 20/07/16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import UIKit

protocol Step3CellDelegate: NSObjectProtocol {
    func didPressDeleteSocial(_ cell: Step3Cell)
//    func didPressDeleteSubcategory(_ cell: Step3Cell)
    func didPressDateSelection(_ sender: UIButton)
    func consumerTextViewDidChange(with text: String)
    func levelTextFieldDidChange(with text: String)
    func urlTextFieldDidChange(with text: String)
    func socialUrlTextFieldDidChange(with text: String, in cell: Step3Cell)
}

class Step3Cell: UITableViewCell, UITextViewDelegate {
    
    @IBOutlet weak var infoTextView: TextView!
    @IBOutlet weak var levelTextField: TextFieldRxdisabled!
    @IBOutlet weak var urlTextField: TextFieldRxdisabled!
    @IBOutlet weak var socialUrlTextField: TextFieldRxdisabled!
    @IBOutlet weak var socialIcon: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
//    @IBOutlet weak var subcategoryLabel: UILabel!
    @IBOutlet weak var beginDateButton: RoundedButton!
    @IBOutlet weak var endDateButton: RoundedButton!
    
    weak var delegate: Step3CellDelegate?

	override func layoutSubviews() {
		super.layoutSubviews()
		infoTextView?.placeholder = "addcontroller.maincustomers".localize()
	}
	
    override func awakeFromNib() {
        super.awakeFromNib()

        if let textView = infoTextView { textView.delegate = self }
        
        if let textField = levelTextField, let url = urlTextField{
            textField.addTarget(self, action: #selector(levelChanged(_ :)), for: .editingChanged)
            url.addTarget(self, action: #selector(urlChanged(_ :)), for: .editingChanged)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    @IBAction func deleteButtonHandler(_ sender: AnyObject) {
//        delegate?.didPressDeleteSubcategory(self)
//    }
	
    @IBAction func socialDeleteButtonHandler(_ sender: AnyObject) {
        delegate?.didPressDeleteSocial(self)
    }
    
    @IBAction func beginButtonHandler(_ sender: UIButton) {
        delegate?.didPressDateSelection(sender)
    }
    
    @IBAction func endButtonHandler(_ sender: UIButton) {
        delegate?.didPressDateSelection(sender)
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        delegate?.consumerTextViewDidChange(with: textView.text)
    }
    
    @objc func levelChanged(_ textField: UITextField) {
        delegate?.levelTextFieldDidChange(with: textField.text!)
    }
    
    @objc func urlChanged(_ textField: UITextField) {
        delegate?.urlTextFieldDidChange(with: textField.text!)
    }
    
    func socialUrlChanged(_ textField: UITextField) {
        delegate?.socialUrlTextFieldDidChange(with: textField.text!, in: self)
    }
}
