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
    func get<T: Decodable>(modelType: T.Type, url: String, completion: @escaping(Result<T, NetworkError>) -> Void) {
        Log.event("Network request initiated with Url: \(url)", .info)
        guard let url = URL(string: url) else {
            Log.event("error while creating url", .error)
            completion(.failure(.emptyUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data, error == nil else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                Log.event("Network Request failed. Status code: \(statusCode)", .error)
                completion(.failure(.requestFailed))
                return
            }
            Log.event("Network Request successful", .info)
            do {
                let result = try JSONDecoder().decode(modelType.self, from: data)
                completion(.success(result))
                
            } catch let DecodingError.keyNotFound(key, context) {
                Log.event("Key '\(key)' not found: \(context.debugDescription)", .error)
                Log.event("codingPath: \(context.codingPath)", .error)
                completion(.failure(.decodingError))
            } catch let DecodingError.valueNotFound(value, context) {
                Log.event("Value '\(value)' not found: \(context.debugDescription)", .error)
                Log.event("codingPath: \(context.codingPath)", .error)
                completion(.failure(.decodingError))
            } catch let DecodingError.typeMismatch(type, context)  {
                Log.event("TypeR'\(type)' mismatch: \(context.debugDescription)", .error)
                Log.event("codingPath: \(context.codingPath)", .error)
                completion(.failure(.decodingError))
            } catch {
                Log.event("Failed with error reason unknown", .error)
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

/*
 func decode<T>(modelType: T.Type) where T : Decodable {
     let myStruct = try! JSONDecoder().decode(modelType, from: data!)
     ...
 }*/
