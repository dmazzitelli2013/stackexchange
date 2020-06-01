//
//  UITableView+Setup.swift
//  StackExchange
//
//  Created by David Mazzitelli on 31/05/20.
//  Copyright © 2020 David Mazzitelli. All rights reserved.
//

import UIKit

extension UITableView {

    func setup(cellIdentifiers: [String] = [], contentInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)) {
        self.backgroundColor = UIColor.clear
        self.allowsSelection = false
        self.separatorStyle = .none
        self.contentInset = contentInset
        self.rowHeight = UITableView.automaticDimension
        
        cellIdentifiers.forEach { identifier in
            self.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        }
    }

}
