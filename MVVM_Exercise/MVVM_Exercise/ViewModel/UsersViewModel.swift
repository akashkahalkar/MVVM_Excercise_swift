//
//  UsersViewModel.swift
//  MVVM_Exercise
//
//  Created by akash on 22/07/20.
//  Copyright © 2020 akash. All rights reserved.
//

import Foundation

class UserViewModel {
    
    private var users: [User]?
    
    func toggleFavorite(index: Int) -> Bool {
        if var users = users, users.indices.contains(index) {
            users[index].toggleFavorite()
            return true
        }
        return false
    }
    
    /// Toggle favorite state for given user id
    /// - Parameter id: id of the user to be updated
    func updateFavoriteState(id: Int) -> Bool {
        if let index = users?.firstIndex(where: {$0.id == id}) {
            users?[index].toggleFavorite()
            return true
        }
        return false
    }
    
    func getUser(at index: Int) -> User? {
        if let users = self.users, users.indices.contains(index) {
            return users[index]
        }
        return nil
    }
    
    func setUser(users: [User]) {
        self.users = users
    }
    
    func getUsers() -> [User] {
        if let users = users {
            return users
        }
        return []
    }
    
    func getUserCount() -> Int {
        if let users = users {
            return users.count
        }
        return 0
    }
    
    func tableRowCount() -> Int {
        return getUserCount()
    }
    
    func fetchUsers(completion: @escaping(NetworkError?) -> Void) {
        
        NetworkManager.shared.get(url: URLEndpoints.getUsers, completion: { result in
            
            switch result {
                
            case .success(let users):
                self.setUser(users: users)
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        })
    }
}
