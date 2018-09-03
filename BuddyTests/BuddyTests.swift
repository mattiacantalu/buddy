//
//  BuddyTests.swift
//  Buddy
//
//  Created by Mattia Cantalù on 03/09/2018.
//  Copyright © 2018 YOOX NET-A-PORTER GROUP S.p.A. All rights reserved.
//  

import XCTest
@testable import Buddy

class BuddyTests: XCTestCase {

    var service: BuddyService?

    override func setUp() {
        super.setUp()
        let conf = Configuration(token: "yN9KTZm4s8m5R7X1YcvZxRH7wQ1xLjgp8ibCd11lf4Ne4DJnJdsWEqbYZDrP8vH7OFG8rzHfMDvAIbToGxsQGAxhWUs6C0Sd7A4WGmPCSYDHq1dIUE3kXjyesVNv",
                                 urlString: "https://api.buddybuild.com/v1")
        service = BuddyService(configuration: conf)
    }
    
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        super.tearDown()
//    }

    func testExample() {
//        service?.getApps(completion: { result in
//            switch result {
//            case .success(let response):
//                XCTAssertNotNil(response)
//            case .failure(let error):
//                print("Error: \(error)")
//            }
//        })
    }
}
