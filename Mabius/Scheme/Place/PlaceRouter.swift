//
//  PlaceRouter.swift
//  Mabius
//
//  Created by Timafei Harhun on 2/27/17.
//  Copyright (c) 2017 vice3.agency. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol PlaceRouterInput {
    func dismiss()
}

class PlaceRouter: PlaceRouterInput {
    
    weak var viewController: PlaceViewController!

    init(viewController: PlaceViewController) {
        self.viewController = viewController
    }

    // MARK: - Navigation

    func dismiss() {
        viewController.dismiss(animated: true, completion: nil)
    }
}
