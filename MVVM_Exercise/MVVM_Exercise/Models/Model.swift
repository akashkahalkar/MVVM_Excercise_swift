//
//  Model.swift
//  MVVM_Exercise
//
//  Created by akash on 22/07/20.
//  Copyright © 2020 akash. All rights reserved.
//


import Foundation

struct User: Decodable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
    var fav: Bool = false
    
    enum CodingKeys: CodingKey {
        case id, name, username, email, address, phone, website, company
    }
    
    mutating func toggleFavorite() {
        fav.toggle()
    }
}

struct Address: Decodable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: GeoCode
}

struct GeoCode: Decodable {
    let lat: String
    let lng: String
}

struct Company: Decodable {
    let name: String
    let catchPhrase: String
    let bs: String
}

struct URLEndpoints {
    static let getUsers = "https://jsonplaceholder.typicode.com/users"
}

