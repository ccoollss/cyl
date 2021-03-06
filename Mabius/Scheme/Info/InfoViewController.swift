//
//  InfoViewController.swift
//  Mabius
//
//  Created by Timafei Harhun on 2/20/17.
//  Copyright (c) 2017 vice3.agency. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

class InfoViewController: BaseViewController {
    
    @IBOutlet weak var navbarLabel: NavbarLabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var label: TitleLabel!
    @IBOutlet weak var button: Button!
    
    var type = InfoType.application

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareView()
        
        button.addTarget(self, action: #selector(completed), for: .touchUpInside)
    }

    // MARK: - Event handling
    
    @objc func completed() {
        if type == .restorePass || type == .confirmMail {
            alert("messages.linkSentAgain", message: "", cancel: "OK")
        } else {
            backButtonHandler(button)
        }
    }
    
    // MARK: - Display logic
    
    func prepareView() {
        
        let model = InfoModels.ViewModel.InfoData(type: type)
        
        navbarLabel.text = model.navbarText
        label.text = model.labelText
        icon.image = UIImage(named: model.iconName)
        button.setTitle(model.buttonTitle, for: UIControlState())
    }
    
    override var stackPolicy: StackPolicy {
        switch type {
        case .confirmMail, .restorePass:
            return .replaceLast
        case .application:
            return .clearStack
        }
    }
    
    override func prepareWithParams(_ params: [String : String]) {
        if let type = InfoType(rawValue: Int(params["type"]!)!) { self.type = type }
    }
}
