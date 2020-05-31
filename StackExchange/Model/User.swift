//
//  User.swift
//  StackExchange
//
//  Created by David Mazzitelli on 31/05/20.
//  Copyright © 2020 David Mazzitelli. All rights reserved.
//

import Foundation

class User {
    
    var userId: UInt64?
    var displayName: String?
    var reputation: Int?
    var profileImageURL: String?
    
    var badgesGold: Int = 0
    var badgesSilver: Int = 0
    var badgesBronze: Int = 0
    
}

class UserMapper {
    
    static func userFromJSON(_ json: [String: Any?]?) -> User? {
        guard let json = json else { return nil }
        guard let items = json["items"] as? [[String: Any?]] else { return nil }
        guard let firstItem = items.first else { return nil }
        
        let userId = firstItem["user_id"] as? UInt64
        let displayName = firstItem["display_name"] as? String
        let profileImageURL = firstItem["profile_image"] as? String
        let reputation = firstItem["reputation"] as? Int
        
        let user = User()
        user.userId = userId
        user.displayName = displayName
        user.reputation = reputation
        user.profileImageURL = profileImageURL
        
        if let badgeCounts = firstItem["badge_counts"] as? [String: Int] {
            user.badgesGold = badgeCounts["gold"] ?? 0
            user.badgesSilver = badgeCounts["silver"] ?? 0
            user.badgesBronze = badgeCounts["bronze"] ?? 0
        }
        
        return user
    }
    
}
