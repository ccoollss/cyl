//
//  CategoriesProvider.swift
//  Mabius
//
//  Created by Timafei Harhun on 09.03.16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import Foundation

class CategoriesProvider {
    
    static let instance = CategoriesProvider()
    
    fileprivate var categories = [Int: Category]()
    fileprivate var subcategories = [Int: SubCategory]()
    
    func load(completion: @escaping (_ : Bool) -> Void ) {
        let group = DispatchGroup()
        var categories = [Int: Category]()
        var subcategories = [Int: SubCategory]()
        
        GetCategories().exec { result in
            switch result {
            case .value(let response):
                for category in response.array {
                    if let id = category.id { categories[id] = category }
                }

                for id in categories.keys {
                    group.enter()
                    GetSubCategories(categoryId: id).exec { result in
                        switch result {
                        case .value(let response):
                            for subcategory in response.array {
                                if let id = subcategory.id { subcategories[id] = subcategory }
                            }
                            group.leave()
                        case .error(let error):
                            group.leave()
                            print(error)
                        }
                    }
                }

                group.notify(queue: .main, execute: {
                    self.categories = categories
                    self.subcategories = subcategories

                    // Post notification
                    NotificationCenter.default.post(name: categoriesLoadedNotification, object: nil)
                    
                    completion(true)
                })

            case .error(let error):
                completion(false)
                print(error)
            }
        }
    }
    
    func getCategories(by ids: [Int]) -> [Category] {
        var items = [Category]()
        for id in ids { if let category = categories[id] { items.append(category) } }
        return items
    }
    
    func getSubcategories(by ids: [Int]) -> [SubCategory] {
        var items = [SubCategory]()
        for id in ids { if let subcategory = subcategories[id] { items.append(subcategory) } }
        return items
    }
    
    func getCategories() -> [Category] {
        return Array(categories.values)
    }
    
    func getSubcategories() -> [SubCategory] {
        return Array(subcategories.values)
    }
}

// Define identifier
let categoriesLoadedNotification = Notification.Name("categoriesLoadedNotification")
