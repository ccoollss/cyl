//
//  RestorePassViewControllerViewController.swift
//  Mabius
//
//  Created by Work on 2/20/17.
//  Copyright (c) 2017 vice3.agency. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit
import SwiftyUserDefaults

class RestorePassViewController: BaseViewController, RestorePassPresenterOutput {
    
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var recoverButton: Button!
    
    var output: RestorePassInteractorInput!
    var router: RestorePassRouter!
    
    var input: RestorePassModels.Input {
        return RestorePassModels.Input (email: emailTextField.text)
    }
    
    // MARK: - Object lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        
        RestorePassConfigurator.instance.configure(viewController: self)
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.becomeFirstResponder()
        emailTextField.addTarget(self, action: #selector(inputChanged), for: .editingChanged)
        
        inputChanged()
    }

    // MARK: - Event handling

    @IBAction func recover() {
        output.restore(with: input)
    }
    
    @objc func inputChanged() {
        output.checkInput(input)
    }
    
    // MARK: - Display logic
    
    func didRestore() {
        router.proceedNext()
    }
    
    func showError(_ error: String) {
        alert("Errors.error".localize(), message: error, cancel: "OK")
    }
    
    func toggleButton(_ isEnabled: Bool) {
        recoverButton.isEnabled = isEnabled
    }
    
    func toggleView(_ isEnabled: Bool) {
        view.isUserInteractionEnabled = isEnabled
    }
}