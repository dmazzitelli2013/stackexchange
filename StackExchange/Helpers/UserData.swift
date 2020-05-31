//
//  UserData.swift
//  StackExchange
//
//  Created by David Mazzitelli on 31/05/20.
//  Copyright © 2020 David Mazzitelli. All rights reserved.
//

import Foundation

class UserData {
    
    static let shared = UserData()
    
    var accessToken: String?
    
    private init() {}
    
}
