//
//  APIClient.swift
//  StackExchange
//
//  Created by David Mazzitelli on 31/05/20.
//  Copyright © 2020 David Mazzitelli. All rights reserved.
//

import Foundation

enum APIMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
    case PATCH
}

class APIClient {
    
    static let shared = APIClient()
    
    private let session: URLSession = URLSession(configuration: .default)
    
    var baseURL: String = Constants.SOAPIURL
    
    init() {}
    
    func callAPI(_ url: String, method: APIMethod = .GET, headers: [String: String]? = nil, parameters: [String: Any?]? = nil, completion: @escaping([String: Any]?, Error?) -> Void) {
        let urlString = baseURL + url
        guard let request = createRequestForURL(urlString, method: method, headers: headers, parameters: parameters) else { return }

        let task = session.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                self.callCompletionFromMainThread(nil, NSError(domain: "", code: 500, userInfo: nil), completion)
                return
            }
            
            guard [200, 201].contains(httpResponse.statusCode) else {
                self.callCompletionFromMainThread(nil, NSError(domain: "", code: httpResponse.statusCode, userInfo: nil), completion)
                return
            }
            
            if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                self.callCompletionFromMainThread(json, nil, completion)
            } else {
                self.callCompletionFromMainThread(nil, nil, completion)
            }
        }
        
        task.resume()
    }
    
    private func callCompletionFromMainThread(_ json: [String: Any]?, _ error: Error?, _ completion: @escaping([String: Any]?, Error?) -> Void) {
        DispatchQueue.main.async {
            completion(json, error)
        }
    }
    
    private func createRequestForURL(_ urlString: String, method: APIMethod, headers: [String: String]? = nil, parameters: [String: Any?]?) -> URLRequest? {
        switch method {
        case .GET: return createGETRequestForURL(urlString, headers: headers, parameters: parameters)
        case .POST: return createPOSTRequestForURL(urlString, headers: headers, parameters: parameters)
        default: return nil
        }
    }
    
    private func createGETRequestForURL(_ urlString: String, headers: [String: String]?, parameters: [String: Any?]?) -> URLRequest? {
        guard var components = URLComponents(string: urlString) else { return nil }
        
        if let parameters = parameters {
            var queryItems: [URLQueryItem] = []
            parameters.keys.forEach { key in
                if let value = parameters[key] as? String {
                    queryItems.append(URLQueryItem(name: key, value: value))
                }
            }
            components.queryItems = queryItems
            components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        }
        
        guard let url = components.url else { return nil }
        
        var request = createCommonRequest(url, headers: headers)
        request.httpMethod = APIMethod.GET.rawValue
        
        return request
    }
    
    private func createPOSTRequestForURL(_ urlString: String, headers: [String: String]?, parameters: [String: Any?]?) -> URLRequest? {
        guard let url = URL(string: urlString) else { return nil }
        var request = createCommonRequest(url, headers: headers)
        request.httpMethod = APIMethod.POST.rawValue
        
        if let parameters = parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        return request
    }
    
    private func createCommonRequest(_ url: URL, headers: [String: String]?) -> URLRequest {
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
    
}
