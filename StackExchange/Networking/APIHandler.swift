//
//  APIHandler.swift
//  StackExchange
//
//  Created by David Mazzitelli on 31/05/20.
//  Copyright © 2020 David Mazzitelli. All rights reserved.
//

import Foundation

class APIHandler {
    
    func getUserInformation(_ completion: @escaping(User?) -> Void) {
        let parameters = [
            "key": Constants.SOKey,
            "access_token": UserData.shared.accessToken,
            "site": Constants.SOAPISite
        ]
        
        APIClient.shared.callAPI("me", parameters: parameters) { (response, error) in
            if let _ = error {
                completion(nil)
            } else {
                completion(UserMapper.userFromJSON(response))
            }
        }
    }
    
    func getBadges(desc: Bool, byRank: Bool, page: Int, completion: @escaping([Badge]?, Bool) -> Void) {
        let parameters = [
            "key": Constants.SOKey,
            "access_token": UserData.shared.accessToken,
            "site": Constants.SOAPISite,
            "sort": byRank ? "rank" : "name",
            "order": desc ? "desc" : "asc",
            "page": String(page)
        ]
        
        APIClient.shared.callAPI("users/1000/badges", parameters: parameters) { (response, error) in
            if let _ = error {
                completion(nil, false)
            } else {
                var badges = [Badge]()
                if let items = response?["items"] as? [[String: Any]] {
                    for item in items {
                        if let badge = BadgeMapper.badgeFromJSON(item) {
                            badges.append(badge)
                        }
                    }
                }
                
                let hasMore = response?["has_more"] as? Bool ?? false
                completion(badges, hasMore)
            }
        }
    }
    
    func logout(_ completion: @escaping() -> Void) {
        let api = "access-tokens/" + (UserData.shared.accessToken ?? "") + "/invalidate"
        APIClient.shared.callAPI(api) { (response, error) in
            completion()
        }
    }
    
}
