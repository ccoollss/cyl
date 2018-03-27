//
//  Threading.swift
//  Mabius
//
//  Created by Andrey Toropchin on 21.03.17.
//  Copyright © 2017 vice3.agency. All rights reserved.
//

import Foundation

func async(queue: DispatchQueue = DispatchQueue.main, block: @escaping () -> Void) {
    queue.async(execute: block)
}

func background(block: @escaping () -> Void) {
    async(queue: DispatchQueue.global(qos: .default), block: block)
}

func after(seconds: Double, block: @escaping () -> Void) {
    let time = DispatchTime.now() + Double(Int64(seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: time, execute: block)
}
