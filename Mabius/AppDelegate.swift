//
//  AppDelegate.swift
//  Mabius
//
//  Created by Andrey Toropchin on 11.05.16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import UIKit
import Simplicity
import Localize

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
		
		let localize = Localize.shared
	
		// Set your localize provider.
		localize.update(provider: .json)
		// Set your file name
		localize.update(fileName: "mabius")
		// Set your default languaje.
		localize.update(defaultLanguage: "en")
		
        setupTools()
        setupMisc()

        window?.tintColor = UIColor.cylMainDarkColor()

        if ApiConfig.token != nil && !isTesting {
            window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContainerViewController")
        }

        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool
    {
        if self.handleUrl(url) { return true }
        else {
            return Simplicity.application(app, open: url, options: options)
        }
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool
    {
        return Simplicity.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        PushNotificationManager().sendRemoteNotificationsToken(deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error.localizedDescription)
    }
}
