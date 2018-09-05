import XCTest
@testable import Buddy

class ReponseTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    func testBuildsList() {
        let session = MockedSession(json: "builds_list") { _, response, _ in
            XCTAssertEqual("www.sample.com/apps/999/builds?status=success&limit=5", response?.url?.absoluteString)
        }
        let service = Service(session: session,
            dispatcher: SyncDispatcher())
        let config = Configuration(token: "abc123",
                                   baseUrl: "www.sample.com",
                                   service: service)

        BuddyService(configuration: config)
            .getBuilds(appId: "999",
                       size: 5,
                       status: .success,
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


    func testBuildsListWithDefaultValues() {
        let session = MockedSession(json: "builds_list") { _, response, _ in
            XCTAssertEqual("www.sample.com/apps/999/builds?limit=10", response?.url?.absoluteString)
        }
        let service = Service(session: session,
                              dispatcher: SyncDispatcher())
        let config = Configuration(token: "abc123",
                                   baseUrl: "www.sample.com",
                                   service: service)

        BuddyService(configuration: config)
            .getBuilds(appId: "999",
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
        let session = MockedSession(json: "build") { _, response, _ in
            XCTAssertEqual("www.sample.com/builds/abc123", response?.url?.absoluteString)
        }
        let service = Service(session: session,
            dispatcher: SyncDispatcher())
        let config = Configuration(token: "abc123",
                                   baseUrl: "www.sample.com",
                                   service: service)

        BuddyService(configuration: config)
            .getBuild(number: "abc123",
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
        let session = MockedSession(json: "apps") { _, response, _ in
            XCTAssertEqual("www.sample.com/apps", response?.url?.absoluteString)
        }
        let service = Service(session: session,
                              dispatcher: SyncDispatcher())
        let config = Configuration(token: "abc123",
                                   baseUrl: "www.sample.com",
                                   service: service)

        BuddyService(configuration: config)
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


