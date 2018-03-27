//
//  BaseViewController.swift
//  Mabius
//
//  Created by spens on 28/06/16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, Navigation
{
    @IBOutlet weak var navbar: Navbar!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil, queue: OperationQueue.main) { [weak self] notification in self?.keyboardWillChangeFrame(notification) }
    }

    override var title: String? {
        didSet {
            if let navbar = self.navbar {
                if let s = title { navbar.title = s }
            }
        }
    }

    @IBAction func backButtonHandler(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func openRightMenuButtonHandler(_ sender: UIButton) {
        self.sideViewController()?.toogleRightViewController()
    }

    // MARK: Navigation defaults
    
    var presentationPolicy: PresentationPolicy { return .push }
    var stackPolicy: StackPolicy { return .default }
    func prepareWithParams(_ params: [String: String]) {}
}

extension BaseViewController // Keyboard
{
    func keyboardWillChangeFrame(_ notification: Foundation.Notification)
    {
        var scrollView: UIScrollView!
        for view in self.view.subviews {
            if view is UIScrollView {
                scrollView = view as! UIScrollView
            }
        }

        let value = notification.userInfo![UIKeyboardFrameEndUserInfoKey]
        let frame = (value as AnyObject).cgRectValue
        let kbSize = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as AnyObject).cgRectValue.size
        let minSize: CGFloat = min(CGFloat(kbSize.width), CGFloat(kbSize.height))

        var contentInsets: UIEdgeInsets
        if frame!.origin.y < UIScreen.main.bounds.height {
            contentInsets = UIEdgeInsetsMake(0, 0, minSize, 0)
        } else {
            contentInsets = UIEdgeInsets.zero
        }
        if scrollView != nil {
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
        }
    }
}

extension BaseViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension BaseViewController: UIScrollViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navbar?.showDivider = scrollView.contentOffset.y != 0
    }
}

extension BaseViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
}
