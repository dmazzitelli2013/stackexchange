//
//  BadgesViewController.swift
//  StackExchange
//
//  Created by David Mazzitelli on 31/05/20.
//  Copyright © 2020 David Mazzitelli. All rights reserved.
//

import UIKit

class BadgesViewController: BaseViewController, DashboardViewModelDelegate {

    @IBOutlet private weak var sortSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var orderSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: DashboardViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("Badges", comment: "")
        
        setupSegmentedControls()
        setupTableView()
        
        viewModel?.delegate = self
        viewModel?.dashboardViewModelDelegate = self
        viewModel?.getBadges()
    }
    
    private func setupSegmentedControls() {
        sortSegmentedControl.setTitle(NSLocalizedString("Rank", comment: ""), forSegmentAt: 0)
        sortSegmentedControl.setTitle(NSLocalizedString("Name", comment: ""), forSegmentAt: 1)
        orderSegmentedControl.setTitle(NSLocalizedString("Descendant", comment: ""), forSegmentAt: 0)
        orderSegmentedControl.setTitle(NSLocalizedString("Ascendant", comment: ""), forSegmentAt: 1)
    }
    
    private func setupTableView() {
        tableView.setup(cellIdentifiers: [
            BadgeTableViewCell.identifier
        ])
    }
    
    func viewModelDidUpdateBadges(badges: [Badge]?) {
        guard let newBadges = badges, let allBadges = viewModel?.badges else { return }
        
        var indexPaths: [IndexPath] = []
        for badge in newBadges {
            if let index = allBadges.firstIndex(where: { $0.badgeId == badge.badgeId }) {
                indexPaths.append(IndexPath(row: index, section: 0))
            }
        }
        
        tableView.beginUpdates()
        tableView.insertRows(at: indexPaths, with: .fade)
        tableView.endUpdates()
    }
    
    private func shouldLoadMoreBadges() {
        if let isLoading = viewModel?.isLoadingMoreBadges, !isLoading, let hasMore = viewModel?.hasMoreBadges, hasMore {
            viewModel?.loadMoreBadges()
        }
    }
    
    @IBAction private func updatedSortControl() {
        switch sortSegmentedControl.selectedSegmentIndex {
        case 0:
            viewModel?.loadBadgesByRank = true
            break
        default:
            viewModel?.loadBadgesByRank = false
        }
        
        viewModel?.getBadges()
        tableView.reloadData()
    }
    
    @IBAction private func updatedOrderControl() {
        switch orderSegmentedControl.selectedSegmentIndex {
        case 0:
            viewModel?.loadBadgesDesc = true
            break
        default:
            viewModel?.loadBadgesDesc = false
        }
        
        viewModel?.getBadges()
        tableView.reloadData()
    }

}

extension BadgesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.badges.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BadgeTableViewCell.identifier) as? BadgeTableViewCell else {
            return UITableViewCell()
        }
        
        if let badge = viewModel?.badges[indexPath.row] {
            cell.setup(badge)
        }
        
        if indexPath.row + 1 == viewModel?.badges.count {
            shouldLoadMoreBadges()
        }
        
        return cell
    }
    
}
