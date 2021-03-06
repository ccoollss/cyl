//
//  WhoWorker.swift
//  Mabius
//
//  Created by Timafei Harhun on 06/03/17.
//  Copyright (c) 2017 vice3.agency. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import Foundation

protocol WhoWorkerInput {
    func loadLikes(with input: Who.Input)
}

protocol WhoWorkerOutput: class {
    func didLoadLikes(_ likes: [Like])
    func gotError(_ error: Error)
}

class WhoWorker: WhoWorkerInput {
    
    weak var output: WhoWorkerOutput?

    // MARK: - Business Logic

    func loadLikes(with input: Who.Input) {
        GetLikes(pointId: input.pointId).exec { result in
            switch result {
            case .value(let response):
                self.output?.didLoadLikes(response.array)
            case .error(let error):
                self.output?.gotError(error)
            }
        }
    }
}
