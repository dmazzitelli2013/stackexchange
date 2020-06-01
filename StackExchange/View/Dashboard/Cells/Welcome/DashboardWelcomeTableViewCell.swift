//
//  DashboardWelcomeTableViewCell.swift
//  StackExchange
//
//  Created by David Mazzitelli on 31/05/20.
//  Copyright © 2020 David Mazzitelli. All rights reserved.
//

import UIKit

class DashboardWelcomeTableViewCell: UITableViewCell {

    static let identifier = "DashboardWelcomeTableViewCell"
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        welcomeLabel.text = NSLocalizedString("Welcome", comment: "") + ","
    }
    
    func setup(_ user: User?) {
        nameLabel.text = user?.displayName
    }
    
}
