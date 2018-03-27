//
//  HintsViewController.swift
//  Mabius
//
//  Created by spens on 27/07/16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

protocol HintsViewControllerDelegate: class {
    func hideHints()
}

import UIKit

class HintsViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var firstHintContainer: UIView!
    @IBOutlet weak var firstHintContainerTop: NSLayoutConstraint!
    
    weak var delegate: HintsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.next(_:)))
        self.view.addGestureRecognizer(tap)
    }
    
    func setupFirstHint(_ y: CGFloat) {
        if y == 0 {
            firstHintContainer.isHidden = true
            return
        }
        firstHintContainerTop.constant = y
        
        view.layoutIfNeeded()
    }
    
    @objc func next(_ sender: AnyObject) {
        scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x + view.frame.width, y: 0), animated: false)
        if scrollView.contentOffset.x + view.frame.width >= view.frame.width * 6 {
            closeHintButtonHandler(nil)
        }
    }
    
    @IBAction func closeHintButtonHandler(_ sender: AnyObject?) {
        delegate?.hideHints()
    }
}
