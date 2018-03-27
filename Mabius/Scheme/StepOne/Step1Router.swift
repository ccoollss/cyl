//
//  Step1Router.swift
//  Mabius
//
//  Created by Timafei Harhun on 2/24/17.
//  Copyright (c) 2017 vice3.agency. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol Step1RouterInput {
    func proceedNext()
}

class Step1Router: Step1RouterInput {
    
    weak var viewController: Step1ViewController!

    init(viewController: Step1ViewController) {
        self.viewController = viewController
    }

    // MARK: - Navigation

    func proceedNext() {
        let vc = viewController.storyboard?.instantiateViewController(withIdentifier: "Step2ViewController") as! Step2ViewController
        vc.point = viewController.point
        vc.transfer = Step2.Transfer(step1: viewController.input)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func proceedBack() {
        _ = viewController.navigationController?.popViewController(animated: true)
    }
    
    func proceedFeed() {
        viewController.tabBarController?.selectedIndex = 0
    }
}
