//
//  FeedController.swift
//  Mabius
//
//  Created by Andrey Toropchin on 16.05.16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FeedController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    lazy var viewModel = MockFeedModel()
    let disposeBag = DisposeBag()

    @IBOutlet weak var tableView : UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(viewModel, action: #selector(FeedModel.refresh), forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)

        viewModel.update.observeOn(MainScheduler.instance).subscribeNext { loading in
            self.tableView.reloadData();
            if loading
            {
                self.tableView.setContentOffset(CGPoint(x: 0, y: self.tableView.contentOffset.y - refreshControl.frame.size.height), animated: true)
                refreshControl.beginRefreshing()
            }
            else { refreshControl.endRefreshing() }
        }.addDisposableTo(disposeBag)
        viewModel.refresh()

        navigationItem.title = "CYL"
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Карта", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(FeedController.showMap))
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Фильтр", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(FeedController.showFilter))
    }

    func showMap()
    {
        //self.navigationController?.pushViewController(MapController(), animated: true)
    }

    func showFilter()
    {
        sideViewController()?.toogleRightViewController()
    }
}

// MARK: Table DataSource

extension FeedController
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return viewModel.items.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let item = viewModel.items[indexPath.row]

        var cell = tableView.dequeueReusableCellWithIdentifier("\(item)") as! Cell
        cell.item = item
        return cell as! UITableViewCell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.cellForRowAtIndexPath(indexPath)?.setSelected(false, animated: true)
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 300
    }

//    func scrollViewDidScroll(scrollView: UIScrollView)
//    {
//        let currentOffset = scrollView.contentOffset.y
//        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
//        let deltaOffset = maximumOffset - currentOffset
//
//        if deltaOffset <= 0 { viewModel.loadMore() }
//    }
}
