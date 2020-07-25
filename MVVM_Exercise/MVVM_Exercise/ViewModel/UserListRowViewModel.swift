//
//  UserListRowViewModel.swift
//  MVVM_Exercise
//
//  Created by akash on 24/07/20.
//  Copyright © 2020 akash. All rights reserved.
//

import Foundation

struct UserListRowViewModel {
    
    var user: User
    
    init?(_ user: User?) {
        guard let user = user else { return nil }
        self.user = user
    }
    
    func getUserId() -> Int {
        return user.id
    }
    
    func getName() -> String {
        return user.name
    }
    
    func getUserPhone() -> String {
        if let phone = user.phone.components(separatedBy: " ").first {
            return phone
        }
        return user.phone
    }
    
    func getcompanyName() -> String {
        return user.company.name
    }
    
    func getWebsite() -> String {
        return user.website.checkAndAppend(prefix: "www.")
    }
    
    func getFavImage() -> String {
        user.fav ? "star.fill" : "star"
    }
}

