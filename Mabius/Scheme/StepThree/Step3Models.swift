//
//  Step3Models.swift
//  Mabius
//
//  Created by Timafei Harhun on 2/24/17.
//  Copyright (c) 2017 vice3.agency. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

enum CreatePointFormType: String {
    case project = "CreateProjectPointForm"
    case idea = "CreateIdeaPointForm"
    case event = "CreateEventPointForm"
    
    static func getPointFormTypeBy(projectType: ProjectType) -> CreatePointFormType {
        switch projectType {
            case .project:
                return self.project
            case .idea:
                return self.idea
            case .event:
                return self.event
        }
    }
}

enum PickerType: Int {
    case category = 0
    case subcategory
    case beginDate
    case endDate
}

import UIKit

struct Step3 {
    
    struct Input {
        var point: Point?
        
        var formType: CreatePointFormType
        var categoryId: Int?
        var subcategoriesIds: [Int] = []
        
        var consumer: String?
        var level: String?
        
        var siteUrl : String?
        var socials: [String] = []
        
        var beginDate: Int?
        var endDate: Int?
    }

    struct Transfer {
        var step1: Step1.Input!
        var step2: Step2.Input!
    }

    struct ViewModel {
        var selectedType: ProjectType? = nil
        var selectedCategoryId: Int?
        var selectedSubcategoriesIds: [Int] = []
        
        var consumer: String? = nil
        var level: String? = nil
        
        var siteUrl : String? = nil
        var socials: [Social] = []

        var selectedBeginDate: Date? = nil
        var selectedEndDate: Date? = nil
        
        var selectedSubcategoryIndexPath: IndexPath? = nil
    }
}

struct Social {
    var type: SocialType
    var url: String
}

extension Step3.Input {
    var isValid: Bool {
		if point != nil { return categoryId != nil } //&& !subcategoriesIds.isEmpty }
        if categoryId == nil { return false } //|| subcategoriesIds.isEmpty
        if formType == .event && (beginDate == nil || endDate == nil) { return false }
        guard formType == .project || formType == .idea, let level = level, level.length > 0, let consumer = consumer, consumer.length > 0 else { return formType == .event }
        return true
    }
}

extension Step3.ViewModel {
    func getSocials() -> [String] {
        var socialUrls = [String]()
        for social in socials where social.url != "" { socialUrls.append(social.url) }
        return socialUrls
    }
}
