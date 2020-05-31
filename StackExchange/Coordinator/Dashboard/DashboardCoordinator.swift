//
//  DashboardCoordinator.swift
//  StackExchange
//
//  Created by David Mazzitelli on 31/05/20.
//  Copyright © 2020 David Mazzitelli. All rights reserved.
//

import UIKit

class DashboardCoordinator: BaseCoordinator {

    override func start() {
        let viewController = DashboardViewController.initFromStoryboard(name: "Dashboard")
        let viewModel = DashboardViewModel()
        
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
