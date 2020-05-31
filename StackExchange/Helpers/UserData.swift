//
//  UserData.swift
//  StackExchange
//
//  Created by David Mazzitelli on 31/05/20.
//  Copyright © 2020 David Mazzitelli. All rights reserved.
//

import Foundation

enum UserDataValue: String {
    case accessToken
}

class UserData {
    
    static let shared = UserData()
    
    var accessToken: String? {
        get {
            return read(.accessToken)
        }
        set {
            store(.accessToken, value: newValue)
        }
    }
    
    private init() {}
    
    private func store(_ key: UserDataValue, value: String?) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    private func read(_ key: UserDataValue) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue)
    }
    
}
