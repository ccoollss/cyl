//
//  ChangePassRouter.swift
//  Mabius
//
//  Created by Timafei Harhun on 2/22/17.
//  Copyright (c) 2017 vice3.agency. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol ChangePassRouterInput {
    
    func proceedBack()
}

class ChangePassRouter: ChangePassRouterInput {
    
    weak var viewController: ChangePassViewController!

    init(viewController: ChangePassViewController) {
        self.viewController = viewController
    }

    // MARK: - Navigation

    func proceedBack() {
        UIApplication.openUrl("cyl://back")
    }
}
