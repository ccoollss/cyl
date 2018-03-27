//
//  MKAnnotationExtensions.swift
//  Mabius
//
//  Created by Andrey Toropchin on 08.07.16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import MapKit
import ObjectiveC

var AssociatedObjectHandle: UInt8 = 0

extension MKAnnotation
{
    var point: Point? {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectHandle) as? Point
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
