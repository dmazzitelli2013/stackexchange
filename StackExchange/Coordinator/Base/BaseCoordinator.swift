//
//  BaseCoordinator.swift
//  StackExchange
//
//  Created by David Mazzitelli on 30/05/20.
//  Copyright © 2020 David Mazzitelli. All rights reserved.
//

import UIKit

class BaseCoordinator {
    
    weak var navigationController: UINavigationController?
    
    init(_ navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {}
    
    func goBackToMainScreen() {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
