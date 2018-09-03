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
        let service = Service(session: <#T##URLSession#>, dispatcher: <#T##Dispatcher#>)
        let conf = Configuration(token: <#T##String#>, baseUrl: <#T##String#>, service: <#T##Service#>)
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
