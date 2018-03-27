//
//  AppDelegateExtensions.swift
//  Mabius
//
//  Created by Andrey Toropchin on 11.05.16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

extension AppDelegate
{
    class var instance : AppDelegate { return UIApplication.shared.delegate as! AppDelegate }
    var isTesting : Bool { return ProcessInfo.processInfo.environment["testing"] == "1" }

    func setupTools()
    {
        if !Platform.isSimulator { Fabric.with([Crashlytics.self]) }
    }

    func setupMisc()
    {
        #if STAGE
        print("STAGE VERSION")
        #else
        print("PRODUCTION VERSION")
        #endif

        #if DEBUG
        if isTesting { UIView.setAnimationsEnabled(false) }
        #endif

        let cache = URLCache(memoryCapacity: 4 * 1024 * 1024, diskCapacity: 20 * 1024 * 1024, diskPath: nil)
        URLCache.shared = cache
        print("ENABLED CACHING")

        print("\n")
    }

    func handleUrl(_ url: URL) -> Bool
    {
        if url.scheme == "cyl"
        {
            print("\(url.absoluteString)")
            Navigator.openUrl(url)
            return true
        }
        return false
    }
}
