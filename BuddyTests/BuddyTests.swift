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

    var bService: BuddyService?

    override func setUp() {
        super.setUp()
        var service = Service(session: MockedSession(json: ""),
                              dispatcher: SyncDispatcher())
        let config = Configuration(token: "abc123",
                                   baseUrl: "www.sample.com",
                                   service: service)
        bService = BuddyService(configuration: config)
    }

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

