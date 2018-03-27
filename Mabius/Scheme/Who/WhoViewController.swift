//
//  WhoViewController.swift
//  Mabius
//
//  Created by Timafei Harhun on 06/03/17.
//  Copyright (c) 2017 vice3.agency. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

class WhoViewController: BaseViewController, WhoPresenterOutput {
    
    @IBOutlet weak var tableView: UITableView!
    
    var output: WhoInteractorInput!
    var router: WhoRouter!

    fileprivate var model = Who.ViewModel()
    fileprivate var input = Who.Input(pointId: 0)
    
    // MARK: - Object lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        
        WhoConfigurator.instance.configure(viewController: self)
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 72
        tableView.delegate = self
        
        output.loadLikes(with: input)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    // MARK: - Event handling

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let id = model.likes[indexPath.row].user?.id {
            router.showUserInfo(id)
        }
    }
    
    // MARK: - Display logic

    func didLoadLikes(_ likes: [Like]) {
        model.likes = likes
        tableView.reloadData()        
    }
    
    func showError(_ error: String) {
        alert("Errors.error".localize(), message: error, cancel: "OK")
    }
    
    func toggleView(_ isEnabled: Bool) {
        view.isUserInteractionEnabled = isEnabled
    }
    
    override func prepareWithParams(_ params: [String : String]) {
        if let stringId = params["pointId"], let intId = Int(stringId)  {
            input.pointId = intId
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.likes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        
        if let cell: NotificationCell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell") as? NotificationCell {
            cell.like = model.likes[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}