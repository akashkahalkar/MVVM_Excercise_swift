//
//  UserDetailsViewModelTest.swift
//  MVVM_ExerciseTests
//
//  Created by akash on 24/07/20.
//  Copyright © 2020 akash. All rights reserved.
//

import XCTest
@testable import MVVM_Exercise

class UserDetailsViewModelTest: MVVM_ExerciseTests {
    
    var sut: UserDetailsViewModel?
    
    override func setUp() {
        sut = UserDetailsViewModel(user: getTestUser(), index: 0)
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testgetUserId() {
        XCTAssertNotNil(sut)
        XCTAssertEqual(1, sut!.getUserId())
    }
    
    func testGetUserName() {
        XCTAssertNotNil(sut)
        XCTAssertEqual("(Akashka)", sut!.getUserName())
    }
    
    func testGetName() {
        XCTAssertNotNil(sut)
        XCTAssertEqual("Akash", sut!.getName())
    }
    
    func testGetAddress() {
        let address = "Tingre nagar, Vishrantwadi Pune, 411015"
        XCTAssertNotNil(sut)
        XCTAssertEqual(address, sut!.getAddress())
    }
    
    func testGetCompanyName() {
        XCTAssertNotNil(sut)
        XCTAssertEqual("company name", sut!.getCompanyName())
    }
    
    func testGetCompanyDescription() {
        XCTAssertNotNil(sut)
        XCTAssertEqual("catch phrase", sut!.getCompanyDescription())
    }
    
    func testGetPhone() {
        XCTAssertNotNil(sut)
        XCTAssertEqual("0123456789", sut!.getPhone())
    }
    
    func testGetImage() {
        XCTAssertNotNil(sut)
        XCTAssertEqual("star", sut!.getImageName())
        sut!.updateFavoriteState()
        XCTAssertEqual("star.fill", sut!.getImageName())
    }
}
