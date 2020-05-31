//
//  DashboardViewController.swift
//  StackExchange
//
//  Created by David Mazzitelli on 31/05/20.
//  Copyright © 2020 David Mazzitelli. All rights reserved.
//

import UIKit

class DashboardViewController: BaseViewController, DashboardViewModelDelegate {

    var viewModel: DashboardViewModel? {
        didSet {
            viewModel?.delegate = self
            viewModel?.dashboardViewModelDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("Dashboard", comment: "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.setHidesBackButton(true, animated: false)
        
        viewModel?.getUser()
    }
    
    func viewModelDidUpdateUser(user: User?) {
        // TODO
    }

}
