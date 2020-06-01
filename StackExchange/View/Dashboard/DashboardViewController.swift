//
//  DashboardViewController.swift
//  StackExchange
//
//  Created by David Mazzitelli on 31/05/20.
//  Copyright © 2020 David Mazzitelli. All rights reserved.
//

import UIKit

class DashboardViewController: BaseViewController, DashboardViewModelDelegate, DashboardBadgesTableViewCellDelegate {
    
    @IBOutlet private weak var tableView: UITableView!

    var viewModel: DashboardViewModel? {
        didSet {
            viewModel?.delegate = self
            viewModel?.dashboardViewModelDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("Dashboard", comment: "")
        
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.setHidesBackButton(true, animated: false)
        
        viewModel?.getUser()
    }
    
    private func setupTableView() {
        tableView.setup(cellIdentifiers: [
            DashboardWelcomeTableViewCell.identifier,
            DashboardPictureAndReputationTableViewCell.identifier,
            DashboardBadgesTableViewCell.identifier
        ])
    }
    
    func viewModelDidUpdateUser(user: User?) {
        tableView.reloadData()
    }

    func badgesViewPressed() {
        // TODO
    }
    
    @objc private func logoutButtonPressed() {
        viewModel?.logout()
    }
    
}

extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0: return cellForWelcome(tableView)
        case 1: return cellForPictureAndReputation(tableView)
        case 2: return cellForBadges(tableView)
        default: return UITableViewCell()
        }
    }
    
    private func cellForWelcome(_ tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DashboardWelcomeTableViewCell.identifier) as? DashboardWelcomeTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setup(viewModel?.user)
        
        return cell
    }
    
    private func cellForPictureAndReputation(_ tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DashboardPictureAndReputationTableViewCell.identifier) as? DashboardPictureAndReputationTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setup(viewModel?.user)
        
        return cell
    }
    
    private func cellForBadges(_ tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DashboardBadgesTableViewCell.identifier) as? DashboardBadgesTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setup(viewModel?.user)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let view = Bundle.main.loadNibNamed("DashboardFooterView", owner: self, options: nil)?.first as? DashboardFooterView else { return nil }
        view.frame = CGRect.init(x: 0, y: 0, width: tableView.bounds.width, height: 140)
        view.logoutButton.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
        
        return view
    }
    
}
