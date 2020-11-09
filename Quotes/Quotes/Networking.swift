//
//  Networking.swift
//  Quotes
//
//  Created by Milos Petrusic on 05/11/2020.
//

import Foundation

enum NetworkerError: Error {
    case badResponse
    case badStatusCode(Int)
    case badData
}

class Networking {
    
    static let shared = Networking()
    private let session: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    func getQuote(completion: @escaping (Kanye?, Error?) -> (Void)) {
        let url = URL(string: "https://api.kanye.rest/")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(nil, NetworkerError.badResponse)
                }
                return
            }
            
            guard (200...209).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    completion(nil, NetworkerError.badStatusCode(httpResponse.statusCode))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, NetworkerError.badData)
                }
                return
            }
            do {
                let kanye = try JSONDecoder().decode(Kanye.self, from: data)
                
                DispatchQueue.main.async {
                    completion(kanye, nil)
                }
            }
            catch let error {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    func getImage(completion: @escaping (Data?, Error?) -> (Void)) {
        let url = URL(string: "https://static.euronews.com/articles/stories/04/79/05/44/602x338_cmsv2_76cf9468-8c31-5dec-9107-b94d33bd57c9-4790544.jpg")!
        
        let task = session.downloadTask(with: url) { (localUrl: URL?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(nil, NetworkerError.badResponse)
                }
                return
            }
            
            guard (200...209).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    completion(nil, NetworkerError.badStatusCode(httpResponse.statusCode))
                }
                return
            }
            
            guard let localUrl = localUrl else {
                DispatchQueue.main.async {
                    completion(nil, NetworkerError.badData)
                }
                return
            }
            do {
                let data = try Data(contentsOf: localUrl)
                
                DispatchQueue.main.async {
                    completion(data, nil)
                }
            }
            catch let error {
                completion(nil, error)
            }
        }
        task.resume()

    }
    
}
