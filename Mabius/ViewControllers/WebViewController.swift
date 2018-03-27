//
//  WebViewController.swift
//  Mabius
//
//  Created by Andrey Toropchin on 11.07.16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import UIKit

class WebViewController: BaseViewController
{
    @IBOutlet weak var webView: UIWebView!

    override func prepareWithParams(_ params: [String : String]) {
        guard let title = params["title"] else { return }
        guard let url = params["url"] else { return }

        _ = view // loading IB outlets
        navbar.title = title
        webView.loadRequest(URLRequest(url: URL(string: url)!))
    }
}
