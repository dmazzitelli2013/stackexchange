//
//  BaseViewModel.swift
//  StackExchange
//
//  Created by David Mazzitelli on 30/05/20.
//  Copyright © 2020 David Mazzitelli. All rights reserved.
//

import Foundation

protocol ViewModelDelegate: class {
    func updateIsLoading(isLoading: Bool)
}

class BaseViewModel {
    
    private(set) var isLoading: Bool = false {
        didSet { delegate?.updateIsLoading(isLoading: isLoading) }
    }
    
    weak var delegate: ViewModelDelegate?
    
}
