//
//  PointsDataStorage.swift
//  Mabius
//
//  Created by Timafei Harhun on 3/29/17.
//  Copyright © 2017 vice3.agency. All rights reserved.
//

class PointsDataStorage {
    
    //INSTANCE
    fileprivate static let instance: PointsDataStorage = PointsDataStorage()
    
    fileprivate var points = [Int : Point]()
    
}

// MARK: PointsData storage actions

extension PointsDataStorage {
    
    static func save(point: Point!) {
        if let id = point.id { instance.points[id] = point }
    }
    
    static func getPoint(by pointId: Int) -> Point? {
        return instance.points[pointId]
    }
    
    static func isExistPoint(by pointId: Int) -> Bool {
        return instance.points[pointId] == nil ? false : true
    }
}
