//
//  ProfileWorker.swift
//  Mabius
//
//  Created by Timafei Harhun on 14/03/17.
//  Copyright (c) 2017 vice3.agency. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

protocol ProfileWorkerInput {
   
    func loadCreatedPoints(for userId: Int)
    func loadLikedPoints(for userId: Int)
    
    func like(for point: Point)
    func removeLike(for point: Point)
    
    func getUser(by userId: Int)
}

protocol ProfileWorkerOutput: class {
   
    func didLoadCreatedPoints(_ response: Profile.Output)
    func didLoadLikedPoints(_ response: Profile.Output)
    
    func didLike(for point: Point)
    func didRemoveLike(for point: Point)
    
    func didLoadUser(_ user: User)
    
    func gotError(_ error: Error)
}

class ProfileWorker: ProfileWorkerInput {
    
    weak var output: ProfileWorkerOutput?

    // MARK: - Business Logic
    
    func loadCreatedPoints(for userId: Int) {
        GetUserCreatedPoints(userId: userId).exec { result in
            switch result {
            case .value(let response):
                response.array.forEach({ point in PointsDataStorage.save(point: point) })
                self.output?.didLoadCreatedPoints(Profile.Output(points: response.array))
            case .error(let error):
                self.output?.gotError(error)
            }
        }
    }
    
    func loadLikedPoints(for userId: Int) {
        GetUserLikedPoints(userId: userId).exec { result in
            switch result {
            case .value(let response):
                response.array.forEach({ point in PointsDataStorage.save(point: point) })
                self.output?.didLoadLikedPoints(Profile.Output(points: response.array))
            case .error(let error):
                self.output?.gotError(error)
            }
        }
    }
    
    func like(for point: Point) {
        AddLike(pointId: point.id).exec { result in
            switch result {
            case .value(_):
                self.output?.didLike(for: point)
            case .error(let error):
                self.output?.gotError(error)
            }
        }
    }
    
    func removeLike(for point: Point) {
        _ = RemoveLike(pointId: point.id).exec { result in
            switch result {
            case .value(_):
                self.output?.didRemoveLike(for: point)
            case .error(let error):
                self.output?.gotError(error)
            }
        }
    }
    
    func getUser(by userId: Int) {
        if UsersDataStorage.isExistUser(by: userId) {
            output?.didLoadUser(UsersDataStorage.getUser(by: userId)!)
        } else {
            GetUser(userId: userId).exec { result in
                switch result {
                case .value(let response):
                    UsersDataStorage.save(user: response.object)
                    self.output?.didLoadUser(response.object)
                case .error(let error):
                    self.output?.gotError(error)
                }
            }
        }
    }
}
