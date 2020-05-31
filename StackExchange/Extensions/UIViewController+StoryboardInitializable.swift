//
//  UIViewController+StoryboardInitializable.swift
//  StackExchange
//
//  Created by David Mazzitelli on 30/05/20.
//  Copyright © 2020 David Mazzitelli. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func initFromStoryboard(name: String = "Main") -> Self {
        let storyboard = UIStoryboard(name: name, bundle: Bundle.main)
        let storyboardIdentifier = String(describing: Self.self)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }
    
}
