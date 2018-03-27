//
//  PushNotificationManager.swift
//  Mabius
//
//  Created by Timafei Harhun on 22.03.17.
//  Copyright © 2017 vice3.agency. All rights reserved.
//

import UIKit
import UserNotifications
import SwiftyUserDefaults

class PushNotificationManager {
	
	func registerForRemoteNotification() {
		if #available(iOS 10.0, *) {
			let center = UNUserNotificationCenter.current()
			center.requestAuthorization(options: [.badge, .alert, .sound], completionHandler: { (granted, error) in
				if error == nil && granted {
					DispatchQueue.main.async {
						UIApplication.shared.registerForRemoteNotifications()
					}
				}
			})
		} else {
			let settings = UIUserNotificationSettings(types: [UIUserNotificationType.alert, UIUserNotificationType.badge, UIUserNotificationType.sound], categories: nil)
			UIApplication.shared.registerUserNotificationSettings(settings)
		}
		
		UIApplication.shared.registerForRemoteNotifications()
	}
	
	func sendRemoteNotificationsToken(_ deviceToken: Data) {
		
		var deviceTokenString = ""
		
		for i in 0..<deviceToken.count {
			deviceTokenString += String(format: "%02.2hhx", arguments: [deviceToken[i]])
		}
		
		let params = PushTokenParams()
		params.deviceToken = deviceTokenString
		params.deviceType = "ios"
		
		PushSubscribe(params: params).exec(completion: { response in
			
			switch response {
			case .value(_):
				self.getPushStatus(with: params)
			case .error(let error):
				print("SentRemoteNotificationsToken problem: \(error.localizedDescription)")
			}
		})
	}
	
	fileprivate func getPushStatus(with params: PushTokenParams) {
		
		GetPushStatus(deviceType: params.deviceType, deviceToken: params.deviceToken, env: params.env).exec { result in
			switch result {
			case .value(let response):
				if let status = response.object.status { Defaults[.pushStatus] = status }
				break
			case .error(let error):
				print("\(error.localizedDescription)")
			}
		}
	}
}
