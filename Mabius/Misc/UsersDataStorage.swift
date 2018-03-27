//
//  UsersDataStorage.swift
//  Mabius
//
//  Created by Timafei Harhun on 13.03.17.
//  Copyright © 2017 vice3.agency. All rights reserved.
//

class UsersDataStorage {
    
    //INSTANCE
    fileprivate static let instance: UsersDataStorage = UsersDataStorage()
    
    fileprivate var users = [Int : User]()
    
}

// MARK: UsersData storage actions

extension UsersDataStorage {
    
    static func save(user: User!) {
        instance.users[user.id] = user
    }
    
    static func getUser(by userId: Int) -> User? {
        return instance.users[userId]
    }
    
    static func isExistUser(by userId: Int) -> Bool {
        return instance.users[userId] == nil ? false : true
    }
}
