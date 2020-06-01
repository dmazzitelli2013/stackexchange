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
    
    func logout(_ completion: @escaping() -> Void) {
        let api = "access-tokens/" + (UserData.shared.accessToken ?? "") + "/invalidate"
        APIClient.shared.callAPI(api) { (response, error) in
            completion()
        }
    }
    
}
