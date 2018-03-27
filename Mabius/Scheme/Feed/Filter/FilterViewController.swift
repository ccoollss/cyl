//
//  FilterViewController.swift
//  Mabius
//
//  Created by Work on 3/3/17.
//  Copyright (c) 2017 vice3.agency. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit
import TagListView

protocol FilterViewControllerDelegate: NSObjectProtocol {
    func applyFilters()
}

class FilterViewController: BaseViewController, TagListViewDelegate, FilterPresenterOutput {
    
    @IBOutlet weak var categoryTagView: FilterTagListView!
   
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var sortButton: RoundedButton!
    @IBOutlet weak var sortControls: UIView!
    @IBOutlet weak var projectTopMargin: NSLayoutConstraint!
    
    weak var delegate: FilterViewControllerDelegate?
    
    var output: FilterInteractorInput!
    
    var type = FilterType.feed {
        didSet {
            sortControls.isHidden = type == .map
            projectTopMargin.constant = type == .map ? 0 : 105
            view.layoutIfNeeded()
        }
    }
    
    fileprivate var model = Filter.ViewModel.init()
    
    var input: Filter.Input! {
        return Filter.Input(sort: getSortOption(), categories: getSelectedCategoriesIds())
    }
    
    // MARK: - Object lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        FilterConfigurator.instance.configure(viewController: self)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryTagView.delegate = self
        
        // Register to receive notification
        NotificationCenter.default.addObserver(self, selector: #selector(FilterViewController.categoriesLoaded), name: categoriesLoadedNotification, object: nil)
    
    }
    
    // MARK: - Event handling
    
    @IBAction func sortButtonHandler(_ sender: AnyObject) {
        self.actionSheet(nil, message: nil, cancel: nil, buttons: getButtonsTitles()) { [unowned self] title in
            self.sortButton.setTitle(title, for: .normal)
            self.delegate?.applyFilters()
        }
    }
    
    @IBAction func resetButtonHandler(_ sender: Any) {
        for tag in categoryTagView.selectedTags() { tag.isSelected = false }
        sortButton.setTitle(SortType.new.localizable(), for: .normal)
        delegate?.applyFilters()
    }
    
    @objc func tagPressed(_ title: String, tagView: TagView, sender: TagListView) -> Void {
        tagView.isSelected = !tagView.isSelected
        delegate?.applyFilters()
    }
    
    // MARK: - Display logic
    
    func didLoadProjects() {
        categoryTagView.removeAllTags()
        
        setCategoriesTags()
    }
    
    func toggleView(_ isEnabled: Bool) {
        view.isUserInteractionEnabled = isEnabled
    }
    
    func showError(_ error: String) {
        alert("Errors.error".localize(), message: error, cancel: "OK")
    }
    
    //MARK: - Helpers
    
    func getButtonsTitles() -> [String] {
        return getOptions().map { $0.localizable() }
    }
    
    func getOptions() -> [SortType] {
        return [SortType.new, SortType.distance]
    }
    
    func getSortOption() -> String {
        return getOptions()[0].rawValue
    }
    
    func getSelectedCategoriesIds() -> [Int] {
        var categoriesIds = [Int]()
        for tag in categoryTagView.selectedTags() {
            if let text = tag.titleLabel?.text, let id = model.categories[text] {
                categoriesIds.append(id)
            }
        }
        return categoriesIds
    }
    
    func setCategoriesTags() {
        for category in CategoriesProvider.instance.getCategories() {
            if let title = category.title {
                model.categories[title] = category.id
                categoryTagView.addTag(title)
            }
        }
    }
    
    //MARK: - CategoriesLoadedNotification
    
    func categoriesLoaded()  {
        output.loadProjects()
    }
}
