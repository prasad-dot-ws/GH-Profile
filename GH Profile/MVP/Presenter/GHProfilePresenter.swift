//
//  GHProfilePresenter.swift
//  GH Profile
//
//  Created by Prasad De Zoysa on 4/27/21.
//

import Foundation

class GHProfilePresenter {
    
    private let defaults = UserDefaults.standard
    
    init() {
    }
    
    func fetchGitHubUserProfile(login: String, forceReload: Bool = false, completion: @escaping (Result<GHUser, Error>) ->()){
        if (forceReload) {
            URLCache.shared.removeAllCachedResponses()
            URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
            
            defaults.removeObject(forKey: Constants.CACHE_EXPIRY_DATE_KEY)
        }
        
        if let date = defaults.value(forKey: Constants.CACHE_EXPIRY_DATE_KEY) {
            if ((date as! Date) < Date()){
                URLCache.shared.removeAllCachedResponses()
                URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
            }
        }
        
        let sessionConfig = URLSessionConfiguration.default
        let authValue: String? = "Bearer \(Constants.GITHUB_GRAPH_API_KEY)"
        let parameterDictionary = ["query" : "query { user(login: \"\(login)\") { id avatarUrl(size: 150) email followers { totalCount } following { totalCount } name login pinnedItems(first: 3) { nodes { ... on Repository { name description stargazerCount languages(first: 1, orderBy: {field: SIZE, direction: DESC}) { nodes { color id name } } owner { avatarUrl(size: 50) login } } } } repositories(first: 10) { nodes { ... on Repository { name description stargazerCount languages(first: 1, orderBy: {field: SIZE, direction: DESC}) { nodes { color id name } } owner { avatarUrl(size: 50) login } } } } starredRepositories(first: 10) { nodes { ... on Repository { name description stargazerCount languages(first: 1, orderBy: {field: SIZE, direction: DESC}) { nodes { color id name } } owner { avatarUrl(size: 50) login } } } } } } "]
        sessionConfig.httpAdditionalHeaders = ["Authorization": authValue ?? ""]
        sessionConfig.requestCachePolicy = .returnCacheDataElseLoad
        
        let session = URLSession(configuration: sessionConfig, delegate: self as? URLSessionDelegate, delegateQueue: nil)
        
        guard let url = URL(string: Constants.GRAPH_QL_ENDPOINT) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        session.dataTask(with: request){(data, response, err) in
            
            if let httpResponse = response as? HTTPURLResponse,
               let date:String = httpResponse.allHeaderFields["Date"] as? String {
                
                let responseDate = date.toDate(withFormat: "E, dd MMM yyyy HH:mm:ss Z")
                
                let expDate = Calendar.current.date(byAdding: .day, value: Constants.CACHE_TIME_TO_LIVE_DAYS, to: responseDate)
                
                self.defaults.set(expDate, forKey: Constants.CACHE_EXPIRY_DATE_KEY)
                
            }
            
            if let err = err {
                completion(.failure(err))
                return
            }
            
            guard let data = data else {
                return
            }
            
            do{
                let decodedData = try
                    JSONDecoder().decode(GitHubResponseData.self, from: data)
                
                completion(.success(decodedData.data.user))
                
            } catch let jsonErr {
                print(jsonErr)
                completion(.failure(jsonErr))
            }
            
        }.resume()
        
    }
    
}
