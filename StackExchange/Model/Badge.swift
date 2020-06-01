//
//  Badge.swift
//  StackExchange
//
//  Created by David Mazzitelli on 31/05/20.
//  Copyright © 2020 David Mazzitelli. All rights reserved.
//

import Foundation

enum BadgeRank: String {
    case gold
    case silver
    case bronze
}

class Badge {
    
    var badgeId: UInt64?
    var type: String?
    var awardCount: Int = 0
    var rank: BadgeRank?
    var name: String?

}

class BadgeMapper {
    
    static func badgeFromJSON(_ json: [String: Any?]?) -> Badge? {
        let badge = Badge()
        
        badge.badgeId = json?["badge_id"] as? UInt64
        badge.type = json?["badge_type"] as? String
        badge.awardCount = json?["award_count"] as? Int ?? 0
        badge.rank = BadgeRank(rawValue: json?["rank"] as? String ?? "")
        badge.name = json?["name"] as? String
        
        return badge
    }
    
}
