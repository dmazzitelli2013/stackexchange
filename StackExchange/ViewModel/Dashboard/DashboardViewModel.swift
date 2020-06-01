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
    func viewModelDidUpdateBadges(badges: [Badge]?)
}

extension DashboardViewModelDelegate { // Make the methods "optional"
    func viewModelDidUpdateUser(user: User?) {}
    func viewModelDidUpdateBadges(badges: [Badge]?) {}
}

class DashboardViewModel: BaseViewModel {

    var coordinator: DashboardCoordinator?
    var apiHandler: APIHandler?
    var user: User?
    var badges: [Badge] = []
    var currentBadgesPage: Int = 1
    var hasMoreBadges: Bool = false
    var isLoadingMoreBadges: Bool = false
    
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
    
    func goToBadges() {
        coordinator?.goToBadgesScreen(self)
    }
    
    func getBadges() {
        isLoading = true
        badges.removeAll()
        currentBadgesPage = 1
        apiHandler?.getBadges(asc: true, page: currentBadgesPage, completion: { (badges, hasMore) in
            if let badges = badges {
                self.badges.append(contentsOf: badges)
                self.dashboardViewModelDelegate?.viewModelDidUpdateBadges(badges: badges)
            }
            self.hasMoreBadges = hasMore
            self.isLoading = false
        })
    }
    
    func loadMoreBadges() {
        isLoadingMoreBadges = true
        currentBadgesPage += 1
        apiHandler?.getBadges(asc: true, page: currentBadgesPage, completion: { (badges, hasMore) in
            if let badges = badges, badges.count > 0 {
                self.badges.append(contentsOf: badges)
                self.dashboardViewModelDelegate?.viewModelDidUpdateBadges(badges: badges)
            }
            self.hasMoreBadges = hasMore
            self.isLoadingMoreBadges = false
        })
    }
    
    func logout() {
        isLoading = true
        apiHandler?.logout {
            UserData.shared.accessToken = nil
            self.isLoading = false
            self.coordinator?.goBackToMainScreen()
        }
    }

}
