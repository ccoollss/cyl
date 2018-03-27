//
//  AboutAppViewController.swift
//  Mabius
//
//  Created by Timafei Harhun on 4/20/17.
//  Copyright © 2017 vice3.agency. All rights reserved.
//

import UIKit

class AboutAppViewController: BaseViewController {

    @IBOutlet weak var aboutAppTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aboutAppTextView.isScrollEnabled = false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        aboutAppTextView.isScrollEnabled = true
    }
}
