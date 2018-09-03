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

    override func setUp() {
        super.setUp()
    }

    func testBuildsList() {
        BuddyService
            .load(json: "builds_list")
            .getBuilds(appId: "172aee62ca0774b1d0a9c60c",
                       completion: { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
            case .failure(let error):
                XCTFail("Should be success! Got: \(error)")
            }
        })
    }
}

private extension BuddyService {
    static func load(json: String) -> BuddyService {
        let service = Service(session: MockedSession(json: json),
                              dispatcher: SyncDispatcher())
        let config = Configuration(token: "abc123",
                                   baseUrl: "www.sample.com",
                                   service: service)
        return BuddyService(configuration: config)
    }
}

