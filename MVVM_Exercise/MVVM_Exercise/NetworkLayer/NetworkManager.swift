//
//  NetworkManager.swift
//  MVVM_Exercise
//
//  Created by akash on 22/07/20.
//  Copyright © 2020 akash. All rights reserved.
//

import Foundation
 
public enum NetworkError: String, Error {
    case emptyUrl = "URL cannot be empty"
    case requestFailed = "Network request failed"
    case decodingError = "Error while decoding parameters"
}

class NetworkManager {
    
    static public let shared = NetworkManager()
    
    private init() {}
    
    /// This method retrives users data from network
    /// - Parameters:
    ///   - url: url string
    ///   - completion: Return list of users on success or respective network error on fail
    func get(url: String, completion: @escaping(Result<[User], NetworkError>) -> Void) {
        
        guard let url = URL(string: url) else {
            debugPrint("error while creating url")
            completion(.failure(.emptyUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.requestFailed))
                return
            }
            do {
                
                let users = try JSONDecoder().decode([User].self, from: data)
                completion(.success(users))
                
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                completion(.failure(.decodingError))
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                completion(.failure(.decodingError))
            } catch let DecodingError.typeMismatch(type, context)  {
                print("TypeR'\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
                completion(.failure(.decodingError))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
