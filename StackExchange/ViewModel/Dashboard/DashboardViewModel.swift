//
//  DashboardViewModel.swift
//  StackExchange
//
//  Created by David Mazzitelli on 31/05/20.
//  Copyright © 2020 David Mazzitelli. All rights reserved.
//

import Foundation

protocol DashboardViewModelDelegate: class {
    func viewModelDidUpdateUser(user: User?)
}

class DashboardViewModel: BaseViewModel {

    var coordinator: DashboardCoordinator?
    var apiHandler: APIHandler?
    var user: User?
    weak var dashboardViewModelDelegate: DashboardViewModelDelegate?
    
    override init() {
        super.init()
        apiHandler = APIHandler()
    }
    
    func getUser() {
        isLoading = true
        apiHandler?.getUserInformation({ user in
            self.user = user
            self.dashboardViewModelDelegate?.viewModelDidUpdateUser(user: user)
            self.isLoading = false
        })
    }

}
