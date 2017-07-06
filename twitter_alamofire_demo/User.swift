//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/17/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

class User {
    
    // add colors
    
    var dictionary: [String: Any]?
    
    var name: String?
    var screenName: String?
    var profileURL: URL?
    var backgroundURL: URL?
    var followers_count: Int?
    var friends_count: Int?
    var location: String?
    var bio: String?
    
    private static var _current: User?
    
    init(dictionary: [String: Any]) {
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        profileURL = URL(string: (dictionary["profile_image_url_https"] as? String)!)
        followers_count = dictionary["followers_count"] as? Int
        friends_count = dictionary["followers_count"] as? Int
        location = dictionary["location"] as? String
        bio = dictionary["description"] as? String
        backgroundURL = URL(string: (dictionary["profile_background_image_url_https"] as? String)!)
    }
    
    static var current: User? {
        get {
            if _current == nil {
                let defaults = UserDefaults.standard
                if let userData = defaults.data(forKey: "currentUserData") {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
                    _current = User(dictionary: dictionary)
                }
            }
            return _current
        }
        set (user) {
            _current = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
        }
    }
}
