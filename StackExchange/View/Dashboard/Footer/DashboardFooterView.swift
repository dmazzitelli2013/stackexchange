//
//  DashboardFooterView.swift
//  StackExchange
//
//  Created by David Mazzitelli on 31/05/20.
//  Copyright © 2020 David Mazzitelli. All rights reserved.
//

import UIKit

class DashboardFooterView: UIView {

    @IBOutlet weak var logoutButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        logoutButton.layer.borderColor = UIColor.red.cgColor
        logoutButton.layer.borderWidth = 1
        logoutButton.layer.cornerRadius = 10
        logoutButton.layer.masksToBounds = true
    }

}
