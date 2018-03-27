//
//  ProfileViewController.swift
//  Mabius
//
//  Created by Timafei Harhun on 14/03/17.
//  Copyright (c) 2017 vice3.agency. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit
import SwiftyUserDefaults

class ProfileViewController: BaseViewController, ProfileCellDelegate, ProfilePresenterOutput {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var switchView: UIView!
    @IBOutlet weak var leftSwitchView: UIView!
    @IBOutlet weak var rightSwitchView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var navbarLabel: NavbarLabel!
    @IBOutlet weak var settingsButton: UIButton!
    
    fileprivate var model = Profile.ViewModel()
    
    var output: ProfileInteractorInput!
    var router: ProfileRouter!
    
    // MARK: - Object lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ProfileConfigurator.instance.configure(viewController: self)
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        tableView.delegate = self
        
        setupUI()
        
        // Register to receive notification
        NotificationCenter.default.addObserver(self, selector: #selector(profileEdited), name: profileEditedNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if model.selfProfile {
            guard let user = User(JSON: Defaults[.userJSON]) else { return }
            model.user = user
            if user.id != nil {
                output.loadCreatedPoints(for: model.user.id)
            }
        } else {
            output.getUser(by: model.userId)
        }
    }
    
    override func prepareWithParams(_ params: [String : String]) {
        if let profile = params["selfProfile"], let selfProfile = profile.toBool(), let userId = params["userId"], let id = userId.toInt(), let fromPoint = params["fromPoint"], let isFromPoint = fromPoint.toBool() {
            model.selfProfile = selfProfile
            model.userId = id
            model.isFromPoint = isFromPoint
        }
    }
    
    func setupUI() {
        settingsButton.isHidden = !model.selfProfile
        switchView.isHidden = !model.selfProfile
        backButton.isHidden = !model.isFromPoint
    }
    
    // MARK: - Event handling
    
    @IBAction func switchHandler(_ sender: AnyObject) {
        if leftSwitchView.isHidden {
            leftSwitchView.isHidden = false
            rightSwitchView.isHidden = true
        } else {
            leftSwitchView.isHidden = true
            rightSwitchView.isHidden = false
        }
        tableView.reloadData()
    }
    
    // MARK: ProfileCellDelegate
    
    func textTapped(_ cell: ProfileCell) {
        if let startIndex = model.user.about?.startIndex, cell.info.text.length > 100, let index = model.user.about?.index(startIndex, offsetBy: 80) {
            cell.info.text = model.user.about?.substring(to: index)
        } else {
            cell.info.text = model.user.about
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    // MARK: - Display logic
    
    func didLoadCreatedPoints(_ response: Profile.Output) {
        model.createdPoints = response.points
        
        if model.selfProfile { output.loadLikedPoints(for: model.user.id) } else { tableView.reloadData() }
    }
    
    func didLoadLikedPoints(_ response: Profile.Output) {
        model.favouritePoints = response.points
        tableView.reloadData()
    }
    
    func didLike(for point: Point) {
        point.isLiked = true
        point.likes = point.likes == nil ? 1 : point.likes! + 1
        
        tableView.reloadData()
    }
    
    func didRemoveLike(for  point: Point) {
        point.isLiked = false
        point.likes = point.likes == nil ? 0 : point.likes! - 1
        
        tableView.reloadData()
    }
    
    func didLoadUser(_ user: User) {
        model.user = user
        output.loadCreatedPoints(for: model.user.id)
    }
    
    func toggleView(_ isEnabled: Bool) {
        view.isUserInteractionEnabled = isEnabled
    }
    
    func showError(_ error: String) {
        alert("Errors.error".localize(), message: error, cancel: "OK")
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if leftSwitchView.isHidden && !rightSwitchView.isHidden { return (model.favouritePoints.count) }
        return model.createdPoints.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if leftSwitchView.isHidden && !rightSwitchView.isHidden {
            if let cell: FeedCell = tableView.dequeueReusableCell(withIdentifier: "FeedCell") as? FeedCell {
                cell.point = model.favouritePoints[indexPath.row]
                cell.delegate = self
                return cell
            }
            
        } else {
            
            if indexPath.row == 0 {
                if let cell: ProfileCell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as? ProfileCell {
                    cell.user = model.user
                    cell.delegate = self
                    cell.counterLabel.text = "profile.points".localize(dictionary: ["count" : "\(model.createdPoints.count)"])
                    return cell
                }
                
            } else {
                
                if let cell: FeedCell = tableView.dequeueReusableCell(withIdentifier: "FeedCell") as? FeedCell {
                    cell.point = model.createdPoints[indexPath.row - 1]
                    cell.delegate = self
                    return cell
                }
            }
        }
        
        return UITableViewCell()
    }
    
    //MARK: - ProfileEditedNotification
    
    @objc func profileEdited()  {
        if let user = User.fromDefaults { model.user = user }
        tableView.reloadData()
    }
}

extension ProfileViewController: FeedCellDelegate {
    
    func openPoint(_ point: Point) {
        if let id = point.id { router.openPointDescription(pointId: id) }
    }
    
    func toggleLikeFor(point: Point) {
        if let isLiked = point.isLiked, isLiked { output.removeLike(for: point) } else { output.like(for: point) }
    }
    
    func openLikes(pointId: Int) {
        router.openLikes(pointId: pointId)
    }
    
    func openComments(pointId: Int) {
        router.openComments(pointId: pointId)
    }
}