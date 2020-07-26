//
//  UserViewModelTest.swift
//  MVVM_ExerciseTests
//
//  Created by akash on 24/07/20.
//  Copyright © 2020 akash. All rights reserved.
//

import XCTest
@testable import MVVM_Exercise


class UserViewModelTest: MVVM_ExerciseTests {

    var sut: UserListViewModel?
    
    override func setUp() {
        sut = UserListViewModel()
    }

    override func tearDown() {
        sut = nil
    }

    //get user should not return even if are not initialized
    func testInitialization() {
        XCTAssertNotNil(sut)
    }
    
    func testSetUser() {
        let user = getTestUser()
        sut!.setUser(users: [user])
        XCTAssertEqual(1, sut!.getUsers().count)
        XCTAssertEqual(user.id, sut!.getUser(at: 0)!.id)
    }
    
    func testToggleFavorite() {
        sut?.setUser(users: [getTestUser()])
        XCTAssertFalse(sut!.updateFavoriteStateForUser(at: 1))
        XCTAssertTrue(sut!.updateFavoriteStateForUser(at: 0))
    }
    
    func testGetUser() {
        XCTAssertNil(sut?.getUser(at: 0))
        let user = getTestUser()
        sut?.setUser(users: [user])
        XCTAssertEqual(1, sut!.getUsers().count)
        XCTAssertEqual(user.id, sut!.getUser(at: 0)!.id)
    }
    
    func testGetUserAt() {
        XCTAssertNil(sut?.getUser(at: 0))
        sut?.setUser(users: [getTestUser()])
        XCTAssertNotNil(sut?.getUser(at: 0))
        XCTAssertEqual(1, sut!.getUser(at: 0)!.id)
    }
    
    func testUpdateFavoriteState() {
        sut?.setUser(users: [getTestUser()])
        let actualState = sut!.getUser(at: 0)!.fav
        XCTAssertFalse(sut!.updateFavoriteStateForUser(at: 2))
        XCTAssertTrue(sut!.updateFavoriteStateForUser(at: 0))
        let changedState = sut!.getUser(at: 0)!.fav
        
        XCTAssertNotEqual(actualState, changedState)
    }
}
