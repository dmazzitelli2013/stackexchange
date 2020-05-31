//
//  LoginViewController.swift
//  StackExchange
//
//  Created by David Mazzitelli on 30/05/20.
//  Copyright © 2020 David Mazzitelli. All rights reserved.
//

import UIKit
import WebKit

class LoginViewController: BaseViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    var viewModel: LoginViewModel? {
        didSet { viewModel?.delegate = self }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupWebView()
    }
    
    private func setupWebView() {
        webView.navigationDelegate = self
        
        showLoading()
        if let urlRequest = viewModel?.urlRequest {
            webView.load(urlRequest)
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideLoading()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .formSubmitted || navigationAction.navigationType == .other {
            viewModel?.processAccessToken(navigationAction.request.url)
        }
        
        decisionHandler(.allow)
    }

}
