//
//  WelcomeViewController.swift
//  Mabius
//
//  Created by spens on 28/06/16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import UIKit

class WelcomeViewController: BaseViewController
{
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
        
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        self.pageControl.currentPage = page
    }
}
