//
//  UserListRowTest.swift
//  MVVM_ExerciseTests
//
//  Created by akash on 24/07/20.
//  Copyright © 2020 akash. All rights reserved.
//

import XCTest
@testable import MVVM_Exercise

class UserListRowTest: MVVM_ExerciseTests {

    var sut: UserListRowViewModel?
    
    override func setUp() {
        sut = UserListRowViewModel(getTestUser())
    }

    override func tearDown() {
        sut = nil
    }

    func testgetUserName() {
        XCTAssertNotNil(sut)
        XCTAssertEqual("Akash", sut!.getUserName())
    }
    
    func testgetUserPhone() {
        XCTAssertNotNil(sut)
        XCTAssertEqual("0123456789", sut!.getUserPhone())
    }
    
    func testgetUserCompanyName() {
        XCTAssertNotNil(sut)
        XCTAssertEqual("company name", sut!.getcompanyName())
    }
    
    func testgetWebsite() {
        XCTAssertNotNil(sut)
        XCTAssertEqual("www.akash.com", sut!.getWebsite())
        
    }
    
    func testgetFavImage() {
        XCTAssertNotNil(sut)
        XCTAssertEqual("suit.heart", sut!.getFavImage())
        sut!.user.toggleFavorite()
        XCTAssertEqual("suit.heart.fill", sut!.getFavImage())
    }

}
