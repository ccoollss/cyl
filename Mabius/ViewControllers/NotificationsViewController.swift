//
//  NotificationsViewController.swift
//  Mabius
//
//  Created by spens on 08/07/16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NotificationsViewController: BaseViewController
{
    @IBOutlet weak var tableView: UITableView!
    
//    fileprivate var viewModel: MockNotificationsModel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.tableFooterView = UIView()

        let refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl)

//        viewModel = MockNotificationsModel(tableView: tableView, refresh: refreshControl)
    }    
}
