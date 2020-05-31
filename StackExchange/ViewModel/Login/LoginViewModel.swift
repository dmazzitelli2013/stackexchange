//
//  LoginViewModel.swift
//  StackExchange
//
//  Created by David Mazzitelli on 30/05/20.
//  Copyright © 2020 David Mazzitelli. All rights reserved.
//

import Foundation

class LoginViewModel: BaseViewModel {
    
    var coordinator: MainCoordinator?
    
    private var clientIDParameter: String {
        return "client_id=" + Constants.SOClientID
    }
    
    private var scopeParameter: String {
        return "scope=read_inbox,no_expiry"
    }
    
    private var redirectURIParameter: String {
        return "redirect_uri=" + Constants.SORedirectURI
    }
    
    var urlRequest: URLRequest {
        let parameters = [clientIDParameter, scopeParameter, redirectURIParameter]
        let parametersString = parameters.joined(separator: "&")
        let urlString = Constants.SOLoginURL + "?" + parametersString
        let url = URL(string: urlString)
        return URLRequest(url: url!)
    }
    
    func login() {
        coordinator?.openLoginScreen()
    }
    
    func processAccessToken(_ url: URL?) {
        guard let urlString = url?.absoluteString else { return }
        
        if urlString.contains("access_token") {
            doProcessAccessToken(urlString)
        }
    }
    
    private func doProcessAccessToken(_ urlString: String) {
        let components = urlString.components(separatedBy: "access_token=")
        if let accessToken = components.last, accessToken.count > 0 {
            UserData.shared.accessToken = accessToken
            loginSuccess()
        }
    }
    
    private func loginSuccess() {
        coordinator?.loginSuccess()
    }
    
}
