//
//  DashboardBadgesTableViewCell.swift
//  StackExchange
//
//  Created by David Mazzitelli on 31/05/20.
//  Copyright © 2020 David Mazzitelli. All rights reserved.
//

import UIKit

protocol DashboardBadgesTableViewCellDelegate: class {
    func badgesViewPressed()
}

class DashboardBadgesTableViewCell: UITableViewCell {
    
    static let identifier = "DashboardBadgesTableViewCell"

    @IBOutlet weak var badgesContainerView: UIView!
    @IBOutlet weak var badgesGoldLabel: UILabel!
    @IBOutlet weak var badgesSilverLabel: UILabel!
    @IBOutlet weak var badgesBronzeLabel: UILabel!
    
    weak var delegate: DashboardBadgesTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        badgesContainerView.layer.cornerRadius = 20
        badgesContainerView.layer.borderColor = UIColor.darkGray.cgColor
        badgesContainerView.layer.borderWidth = 1
        badgesContainerView.layer.masksToBounds = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(badgesViewPressed))
        badgesContainerView.addGestureRecognizer(gesture)
    }
    
    func setup(_ user: User?) {
        badgesGoldLabel.text = String(user?.badgesGold ?? 0)
        badgesSilverLabel.text = String(user?.badgesSilver ?? 0)
        badgesBronzeLabel.text = String(user?.badgesBronze ?? 0)
    }
    
    @objc private func badgesViewPressed() {
        delegate?.badgesViewPressed()
    }
    
}
