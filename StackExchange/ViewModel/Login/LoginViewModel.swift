//
//  LoginViewModel.swift
//  StackExchange
//
//  Created by David Mazzitelli on 30/05/20.
//  Copyright © 2020 David Mazzitelli. All rights reserved.
//

import Foundation

class LoginViewModel: BaseViewModel {
    
    var coordinator: MainCoordinator?
    
    func login() {
        coordinator?.openLoginScreen()
    }
    
}
