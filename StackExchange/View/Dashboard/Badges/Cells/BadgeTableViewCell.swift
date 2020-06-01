//
//  BadgeTableViewCell.swift
//  StackExchange
//
//  Created by David Mazzitelli on 01/06/20.
//  Copyright © 2020 David Mazzitelli. All rights reserved.
//

import UIKit

class BadgeTableViewCell: UITableViewCell {
    
    static let identifier = "BadgeTableViewCell"

    @IBOutlet private weak var badgeImageView: UIImageView!
    @IBOutlet private weak var badgeDescriptionLabel: UILabel!
    
    func setup(_ badge: Badge) {
        badgeImageView.image = UIImage(named: badgeImageName(badge))
        badgeDescriptionLabel.text = badgeDescription(badge)
    }
    
    private func badgeImageName(_ badge: Badge) -> String {
        switch badge.rank {
        case .gold: return "badge_gold"
        case .silver: return "badge_silver"
        case .bronze: return "badge_bronze"
        case .none: return ""
        }
    }
    
    private func badgeDescription(_ badge: Badge) -> String {
        return "(\(badge.awardCount)) \(badge.name ?? "")"
    }
    
}
