//
//  BaseViewController.swift
//  StackExchange
//
//  Created by David Mazzitelli on 30/05/20.
//  Copyright © 2020 David Mazzitelli. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, ViewModelDelegate {
    
    private(set) var loadingView: LoadingView?
    
    func showLoading() {
        loadingView = LoadingView()
        
        if let superView = navigationController?.view {
            loadingView?.show(in: superView)
        } else {
            loadingView?.show(in: view)
        }
    }
    
    func hideLoading() {
        loadingView?.hide()
        loadingView = nil
    }

    func updateIsLoading(isLoading: Bool) {
        if isLoading {
            showLoading()
        } else {
            hideLoading()
        }
    }
    
}
