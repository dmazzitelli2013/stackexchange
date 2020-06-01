//
//  DashboardPictureAndReputationTableViewCell.swift
//  StackExchange
//
//  Created by David Mazzitelli on 31/05/20.
//  Copyright © 2020 David Mazzitelli. All rights reserved.
//

import UIKit

class DashboardPictureAndReputationTableViewCell: UITableViewCell {

    static let identifier = "DashboardPictureAndReputationTableViewCell"
    
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var reputationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.darkGray.cgColor
    }

    func setup(_ user: User?) {
        profileImageView.load(urlString: user?.profileImageURL)
        reputationLabel.text = NSLocalizedString("Reputation", comment: "") + ": " + String(user?.reputation ?? 0)
    }
    
}
