//
//  SocialAuth.swift
//  Mabius
//
//  Created by Andrey Toropchin on 28.06.16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import Foundation
import Simplicity
import SwiftyUserDefaults

typealias SocialCallback = (_ profile: SocialProfile?, _ error: Error?) -> Void

enum SocialType: String
{
    case facebook = "facebook"
    //case vkontakte = "vkontakte"
}

struct SocialProfile
{
    var token: String
    var name: String
}

extension SocialProfile {
    static func forType(_ type: SocialType) -> SocialProfile {
        switch type {
        case .facebook:
            return SocialProfile(token: "", name: Defaults[.fbUsername] ?? "")
//        case .vkontakte:
//            return SocialProfile(token: "", name: Defaults[.vkUsername] ?? "")
        }
    }
}

extension SocialType
{
    func auth(_ completion: @escaping SocialCallback)
    {
        switch self
        {
        case .facebook:
            FbAdapter.auth(completion)
//        case .vkontakte:
//            VkAdapter.auth(completion)
        }
    }
}

protocol SocialAdapter { static func auth(_ completion: @escaping SocialCallback) }

class FbAdapter: SocialAdapter
{
    static func auth(_ completion: @escaping SocialCallback)
    {
        Simplicity.login(Facebook()) { token, error in
            guard let fbToken = token else { completion(nil, error); return }
            background {
                let url = "https://graph.facebook.com/me?fields=first_name,last_name&access_token=\(fbToken)"
                do {
                    let data = try Data(contentsOf: URL(string: url)!)
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSDictionary
                    if json["error"] != nil { throw NSError(domain: NSURLErrorDomain, code: NSURLErrorBadServerResponse, userInfo: nil) }
                    else
                    {
                        let name = "\(String(describing: json["first_name"]!)) \(String(describing: json["last_name"]!))"
                        print("Auth FB: \(name)")
                        let profile = SocialProfile(token: fbToken, name: name)

                        Defaults[.fbUsername] = profile.name
                        async { completion(profile, nil) }
                    }
                }
                catch let err { async { completion(nil, err) } }
            }
        }
    }
}

class VkAdapter: SocialAdapter
{
    static func auth(_ completion: @escaping SocialCallback)
    {
        Simplicity.login(VKontakte()) { token, error in
            guard let vkToken = token else { completion(nil, error); return }
            background {
                let url = "https://api.vk.com/method/users.get?fields=photo_200&access_token=\(vkToken)"
                do {
                    let data = try Data(contentsOf: URL(string: url)!)
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSDictionary
                    if json["error"] != nil { throw NSError(domain: NSURLErrorDomain, code: NSURLErrorBadServerResponse, userInfo: nil) }
                    else
                    {
                        let response = (json["response"] as! NSArray)[0] as! NSDictionary
                        let name = "\(String(describing: response["first_name"]!)) \(String(describing: response["last_name"]!))"
                        let profile = SocialProfile(token: vkToken, name: name)
                        print("Auth VK: \(name)")

                        Defaults[.vkUsername] = profile.name
                        async { completion(profile, nil) }
                    }
                }
                catch let err { async { completion(nil, err) } }
            }
        }
    }
}
