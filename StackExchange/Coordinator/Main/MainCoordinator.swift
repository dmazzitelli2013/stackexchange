//
//  MainCoordinator.swift
//  StackExchange
//
//  Created by David Mazzitelli on 30/05/20.
//  Copyright © 2020 David Mazzitelli. All rights reserved.
//

import UIKit

class MainCoordinator: BaseCoordinator {
    
    override func start() {
        let viewController = MainViewController.initFromStoryboard()
        let viewModel = MainViewModel()
        
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        
        navigationController?.viewControllers = [viewController]
    }
    
    func openLoginScreen() {
        let viewController = LoginViewController.initFromStoryboard()
        let viewModel = LoginViewModel()
        
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        
        navigationController?.present(viewController, animated: true, completion: nil)
    }
    
    func loginSuccess() {
        navigationController?.presentedViewController?.dismiss(animated: true, completion: {
            let dashboardCoordinator = DashboardCoordinator(self.navigationController)
            dashboardCoordinator.start()
        })
    }
    
}
