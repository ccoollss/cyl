//
//  ChangePassViewController.swift
//  Mabius
//
//  Created by Timafei Harhun on 2/22/17.
//  Copyright (c) 2017 vice3.agency. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

class ChangePassViewController: BaseViewController, ChangePassPresenterOutput {
    
    @IBOutlet weak var passTextField: TextField!
    @IBOutlet weak var newPassTextField: TextField!
    @IBOutlet weak var repeatPassTextField: TextField!
    @IBOutlet weak var button: UIButton!
    
    var output: ChangePassInteractorInput!
    var router: ChangePassRouter!
    
    var input: ChangePass.Input {
        return ChangePass.Input(oldPassword: passTextField.text, newPassword: newPassTextField.text, confirmPassword: repeatPassTextField.text)
    }

    // MARK: - Object lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        
        ChangePassConfigurator.instance.configure(viewController: self)
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        passTextField.becomeFirstResponder()
        
        passTextField.addTarget(self, action: #selector(inputChanged), for: .editingChanged)
        newPassTextField.addTarget(self, action: #selector(inputChanged), for: .editingChanged)
        repeatPassTextField.addTarget(self, action: #selector(inputChanged), for: .editingChanged)
        
        output.checkInput(input)
    }

    // MARK: - Event handling

    @IBAction func confirm() {
        output.change(with: input)
    }

    @objc func inputChanged() {
        output.checkInput(input)
    }
    
    // MARK: - Display logic

    func didChanged() {
        router.proceedBack()
    }
    
    func showError(_ error: String) {
        alert("Errors.error".localize(), message: error, cancel: "OK")
    }
    
    func toggleButton(_ isEnabled: Bool) {
        button.isEnabled = isEnabled
    }
    
    func toggleView(_ isEnabled: Bool) {
        view.isUserInteractionEnabled = isEnabled
    }
}
