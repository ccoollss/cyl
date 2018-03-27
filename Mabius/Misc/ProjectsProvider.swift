//
//  ProjectsProvider.swift
//  Mabius
//
//  Created by Timafei Harhun on 3/9/17.
//  Copyright © 2017 vice3.agency. All rights reserved.
//

import Foundation

class ProjectsProvider {
    
    static let instance = ProjectsProvider()
    
    fileprivate var projects = [String: Project]()
    
    func load(completion: @escaping (_ : Bool) -> Void ) {
        
        GetProjects().exec { result in
            switch result {
            case .value(let response):
                for project in response.array {
                    if let id = project.id { self.projects[id] = project }
                }
                completion(true)
            case .error(let error):
                completion(false)
                print(error)
            }
        }
    }
    
    func getProjects() -> [Project] {
        return Array(projects.values)
    }
    
    func getProject(by id: String?) -> Project? {
        if let i = id, let project = projects[i] { return project }
        return nil
    }
}

