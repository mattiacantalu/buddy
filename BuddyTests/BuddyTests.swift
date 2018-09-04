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
                XCTAssertEqual(response.count, 2)
                XCTAssertEqual(response.first?.buildNumber, 1221)
                XCTAssertEqual(response.first?.commit.author, "Developer 1")
                XCTAssertEqual(response.first?.links.install.count, 0)
            case .failure(let error):
                XCTFail("Should be success! Got: \(error)")
            }
        })
    }

    func testBuild() {
        BuddyService
            .load(json: "build")
            .getBuild(number: "123",
                       completion: { result in
                        switch result {
                        case .success(let response):
                            XCTAssertNotNil(response)
                            XCTAssertEqual(response.buildNumber, 2)
                            XCTAssertEqual(response.links.install.count, 1)
                            XCTAssertEqual(response.links.install.first?.name, "m2048 - Release")
                            XCTAssertEqual(response.status, BuildStatus.failed)
                            XCTAssertNil(response.tag)
                        case .failure(let error):
                            XCTFail("Should be success! Got: \(error)")
                        }
            })
    }

    func testApps() {
        BuddyService
            .load(json: "apps")
            .getApps(completion: { result in
                        switch result {
                        case .success(let response):
                            XCTAssertNotNil(response)
                            XCTAssertEqual(response.count, 2)
                            XCTAssertEqual(response.first?.name, "2048 iOS App")
                            XCTAssertEqual(response.first?.id, "58a4e07838704cb2eacd7ce4")
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

