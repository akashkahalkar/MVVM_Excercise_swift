//
//  MVVM_ExerciseTests.swift
//  MVVM_ExerciseTests
//
//  Created by akash on 22/07/20.
//  Copyright © 2020 akash. All rights reserved.
//

import XCTest
@testable import MVVM_Exercise

class MVVM_ExerciseTests: XCTestCase {
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func getTestUser() -> User {
        
        let geoCode = GeoCode(lat: "1.001",
                              lng: "2.001")
        
        let address = Address(street: "Tingre nagar",
                              suite: "Vishrantwadi",
                              city: "Pune",
                              zipcode: "411015",
                              geo: geoCode)
        
        let company = Company(name: "company name",
                              catchPhrase: "catch phrase",
                              bs: "bs")
        
        return User(id: 1,
                        name: "Akash",
                        username: "Akashka",
                        email: "akash@email.com",
                        address: address,
                        phone: "0123456789 x134",
                        website: "akash.com",
                        company: company)
    }
    
}
