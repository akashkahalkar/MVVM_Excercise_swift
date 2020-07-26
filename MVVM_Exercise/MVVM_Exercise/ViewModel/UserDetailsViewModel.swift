//
//  UserDetailsViewModel.swift
//  MVVM_Exercise
//
//  Created by akash on 23/07/20.
//  Copyright © 2020 akash. All rights reserved.
//

import Foundation

class UserDetailsViewModel {
    
    private var user: User
    private let index: Int
    
    init(user: User, index: Int) {
        self.user = user
        self.index = index
    }
    
    
    func getIndex() -> Int {
        return index
    }
    
    func getUserId() -> Int {
        return user.id
    }
    
    func getUserName() -> String {
        return "(\(user.username))"
    }
    
    func getName() -> String {
        return user.name
    }
    
    func getAddress() -> String {
        return "\(user.address.street), \(user.address.suite) \(user.address.city), \(user.address.zipcode)"
    }
    
    func getCompanyName() -> String {
        return user.company.name
    }
    
    func getCompanyDescription() -> String {
        return user.company.catchPhrase
    }
    
    func getPhone() -> String {
        if let phone = user.phone.components(separatedBy: " ").first {
            return phone
        }
        return user.phone
    }
    
    func getImageName() -> String {
        return user.fav ?  "star.fill" : "star"
    }
    
    func updateFavoriteState() {
        user.toggleFavorite()
    }
}
