//
//  UsersViewModel.swift
//  MVVM_Exercise
//
//  Created by akash on 22/07/20.
//  Copyright © 2020 akash. All rights reserved.
//

import Foundation

class UserListViewModel {
    
    private var users: [User]?
    
    func updateFavoriteStateForUser(at index: Int) -> Bool {
        if var user = getUser(at: index) {
            user.toggleFavorite()
            users?[index] = user
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
    
    func getIndex(for id: Int) -> Int? {
        if let index = users?.firstIndex(where: {id == $0.id}) {
            return index
        }
        return nil
    }
    
    
    func getUserRowViewModelList(at index: Int) -> UserListRowViewModel? {
        return UserListRowViewModel(getUser(at: index), with: index)
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
        
        NetworkManager.shared.get(modelType: [User].self, url: URLEndpoints.getUsers, completion: { result in
            
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
