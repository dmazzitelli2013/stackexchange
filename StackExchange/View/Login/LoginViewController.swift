//
//  LoginViewController.swift
//  StackExchange
//
//  Created by David Mazzitelli on 30/05/20.
//  Copyright © 2020 David Mazzitelli. All rights reserved.
//

import UIKit
import WebKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var viewModel: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupWebView()
    }
    
    private func setupWebView() {
        guard let url = URL(string: "https://stackoverflow.com/oauth/dialog") else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }

}
