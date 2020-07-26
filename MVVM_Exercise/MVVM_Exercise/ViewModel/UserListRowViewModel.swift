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
    var index: Int
    
    init?(_ user: User?, with index: Int) {
        guard let user = user else { return nil }
        self.user = user
        self.index = index
    }
    
    func getUserId() -> Int {
        return user.id
    }
    
    func getName() -> String {
        return user.name
    }
    
    func getUserPhone() -> String {
        //let phoneNumbers = user.phone.components(separatedBy: " ")
        
//        if phoneNumbers.count > 1 {
//            let primaryNumber = phoneNumbers[0]
//            let alterNameNumber = phoneNumbers[1]
//            if alterNameNumber.hasPrefix("x") {
//                let startIndex = primaryNumber.index(primaryNumber.endIndex, offsetBy: -((alterNameNumber.dropFirst()).count))
//                let alternateNumber = primaryNumber.replacingCharacters(in: startIndex..<primaryNumber.endIndex, with: alterNameNumber.dropFirst())
//            }
//        }
        
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
    
    func getIndex() -> Int {
        return index
    }
}

