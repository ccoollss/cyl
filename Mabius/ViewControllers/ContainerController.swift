//
//  ContainerController.swift
//  Mabius
//
//  Created by Andrey Toropchin on 19.05.16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import LFSideViewController

class ContainerViewController: LFSideViewController, Navigation
{
    override func viewDidLoad()
    {
        super.viewDidLoad()

        if let controller = storyboard?.instantiateViewController(withIdentifier: "MainTabbarController") {
            contentViewController = controller
        }
        if let controller = storyboard?.instantiateViewController(withIdentifier: "FilterViewController") {
            rightViewController = controller
        }
    }

    // MARK: Side menu

    fileprivate var swipeGesture: UISwipeGestureRecognizer?

    override func presentRightViewController(_ duration: TimeInterval, dampingRatio: CGFloat, velocity: CGFloat, options: UIViewAnimationOptions) {
        self.delegate?.willPresentViewController?(self.rightViewController)
        self.rightViewController?.view.isHidden = false
        self.rightViewControllerVisible = true

        UIView.animate(withDuration: duration,
                                   delay: 0.0,
                                   usingSpringWithDamping: dampingRatio,
                                   initialSpringVelocity: velocity,
                                   options: options,
                                   animations: {
                                    self.contentViewController!.view.frame.origin.x = -(self.view.bounds.size.width - 40)
            }, completion: {_ in
                self.delegate?.didPresentViewController?(self.rightViewController)
        })

        if swipeGesture == nil
        {
            swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(ContainerViewController.closeRight))
            swipeGesture!.direction = .right
        }
        self.view.addGestureRecognizer(swipeGesture!)
    }

    override func hideRightViewController() {
        super.hideRightViewController()
        self.view.removeGestureRecognizer(swipeGesture!)
    }

    override func toogleRightViewController()
    {
        super.toogleRightViewController()
        setNeedsStatusBarAppearanceUpdate()
        view.endEditing(true)
    }

    @objc func closeRight() {
        toogleRightViewController()
    }

    // MARK: Status bar

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }
    override var prefersStatusBarHidden: Bool {
        return rightViewControllerVisible
    }

    // MARK: Navigation 

    var presentationPolicy: PresentationPolicy { return .root }
    var stackPolicy: StackPolicy { return .default }
    func prepareWithParams(_ params: [String: String]) {}
}

extension LFSideViewController
{
    func filterController() -> FilterViewController
    {
        return rightViewController as! FilterViewController
    }
}
