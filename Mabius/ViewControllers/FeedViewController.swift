//
//  FeedViewController.swift
//  Mabius
//
//  Created by spens on 04/07/16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import UIKit
import TagListView
import RxSwift
import RxCocoa
import SwiftyUserDefaults

class FeedViewController: BaseViewController
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var emptyFeedPlaceholder: UIView!
    @IBOutlet weak var filterButtonCheckmark: UIImageView!
    @IBOutlet weak var moderationView: UIView!
    @IBOutlet weak var moderationTitle: FeedTitleLabel!
    @IBOutlet weak var moderationImageView: UIImageView!
    fileprivate lazy var refreshControl = UIRefreshControl()

    fileprivate var viewModel: MockFeedModel!
    
    var point: Point?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        tableView.addSubview(refreshControl)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 350

        viewModel = MockFeedModel(tableView: tableView, emptyPlaceholder: emptyFeedPlaceholder, refresh: refreshControl, search: searchBar)

        rx(sideViewController()!.filterController().viewModel.sorting ~> viewModel.sort)
        rx(sideViewController()!.filterController().viewModel.filtering ~> viewModel.filter)
        rx(sideViewController()!.filterController().viewModel.filterEnabled ~> self.filterButtonCheckmark.rx_toggling)
        
        showHints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fixSearchBar()
        toggleModerationView()
    }
    
    func showHints()
    {
        if !Defaults[.hintsShown] {
            let vc = storyboard?.instantiateViewController(withIdentifier: "HintsViewController") as? HintsViewController
            vc?.view.frame = UIScreen.main.bounds
            tabBarController?.addChildViewController(vc!)
            tabBarController?.view.addSubview((vc?.view)!)
            
            let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? FeedCell
            let y = cell != nil ? (cell?.convert((cell?.commentsButton.frame)!, to: view).minY)! + 7 : 0
            vc?.setupFirstHint(y)
            vc?.end.asObservable().map { $0 }.bindNext { [unowned self] hide in
                if hide {
                    self.tabBarController?.view.subviews.last?.removeFromSuperview()
                    self.tabBarController?.childViewControllers.last?.removeFromParentViewController()
                    Defaults[.hintsShown] = true
                }
            }.addDisposableTo(disposeBag)
        }
    }

    func toggleModerationView() {
        if Defaults[.showModeration] {
            moderationView.isHidden = false
            moderationTitle.text = point?.title
//            if let imgs = point?.images, imgs.count > 0 { moderationImageView.load.request(with: imgs[0]) }
            Defaults[.showModeration] = false
        }
    }
    
    @IBAction override func openRightMenuButtonHandler(_ sender: UIButton) {
        sideViewController()?.filterController().type = .feed
        super.openRightMenuButtonHandler(sender)
    }

    @IBAction func moderationButtonHandler(_ sender: AnyObject) {
        moderationView.isHidden = true
    }
    
    fileprivate func fixSearchBar() {
        refreshControl.beginRefreshing()
        refreshControl.endRefreshing()
        if tableView.contentOffset.y < searchBar.frame.height && emptyFeedPlaceholder.isHidden {
            tableView.contentOffset = CGPoint(x: 0, y: searchBar.frame.height)
        }
    }
}
