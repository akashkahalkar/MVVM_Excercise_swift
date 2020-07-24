//
//  NetworkManagerTest.swift
//  MVVM_ExerciseTests
//
//  Created by akash on 24/07/20.
//  Copyright © 2020 akash. All rights reserved.
//

import XCTest
@testable import MVVM_Exercise

class NetworkManagerTest: XCTestCase {

    var networkManager: NetworkManager?
    
    override func setUp() {
        networkManager = NetworkManager.shared
    }

    override func tearDown() {
        networkManager = nil
    }

    func testEmptyURLError() {
        
        // Create an expectation
        let expectation = self.expectation(description: "Empty Url")
        var networkError: NetworkError?
        
        networkManager?.get(url: "", completion: { (result) in
            
            switch result {
                
            case .success(_):
                expectation.fulfill()
            case .failure(let error):
                networkError = error
                expectation.fulfill()
            }
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(networkError, NetworkError.emptyUrl)
    }
    
    func testInvalidURLError() {
        
        // Create an expectation
        let expectation = self.expectation(description: "Invalid Url")
        var networkError: NetworkError?
        
        networkManager?.get(url: "http://www.123456.nom", completion: { (result) in
            
            switch result {
                
            case .success(_):
                expectation.fulfill()
            case .failure(let error):
                networkError = error
                expectation.fulfill()
            }
        })
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(networkError, NetworkError.requestFailed)
    }

}
