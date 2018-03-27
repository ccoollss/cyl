//
//  ImageFetcher.swift
//  Mabius
//
//  Created by Andrey Toropchin on 03.04.17.
//  Copyright © 2017 vice3.agency. All rights reserved.
//

import UIKit
import Nuke

class ImageFetcher {
    class func fetch(_ url: String?, to: UIImageView, placeholder: UIImage? = nil) {
        to.image = placeholder
        if let s = url, let url = URL(string: s) {
            Nuke.loadImage(with: url, into: to)
        }
    }
    
    class func fetch(_ url: String?, to: UIImageView, placeholder: UIImage? = nil, completion: @escaping Manager.Handler) {
        to.image = placeholder
        if let s = url, let url = URL(string: s) {
            Nuke.loadImage(with: url, into: to, handler: completion)
        }
    }
}
