import XCTest
@testable import Buddy

class ReponseTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    private func configure(session: SessionProtocol) -> Configuration {
        let service = Service(session: session,
                              dispatcher: SyncDispatcher())
        return Configuration(token: "abc123",
                                   baseUrl: "www.sample.com",
                                   service: service)
    }
    
    func testBuildsList() {
        guard let data = JSONMock.loadJson(fromResource: "builds_list") else {
            XCTFail("JSON data error!")
            return
        }
        let mockedSession = MockedSession(data: data,
                                          response: nil,
                                          error: nil) { request in
            XCTAssertEqual("www.sample.com/apps/999/builds?status=success&limit=5", request.url?.absoluteString)
        }

        BuddyService(configuration: configure(session: mockedSession))
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
        guard let data = JSONMock.loadJson(fromResource: "builds_list") else {
            XCTFail("JSON data error!")
            return
        }
        let mockedSession = MockedSession(data: data,
                                          response: nil,
                                          error: nil) { request in
            XCTAssertEqual("www.sample.com/apps/999/builds?limit=10", request.url?.absoluteString)
        }

        BuddyService(configuration: configure(session: mockedSession))
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
        guard let data = JSONMock.loadJson(fromResource: "build") else {
            XCTFail("JSON data error!")
            return
        }
        let mockedSession = MockedSession(data: data,
                                          response: nil,
                                          error: nil) { request in
            XCTAssertEqual("www.sample.com/builds/abc123", request.url?.absoluteString)
        }

        BuddyService(configuration: configure(session: mockedSession))
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
        guard let data = JSONMock.loadJson(fromResource: "apps") else {
            XCTFail("JSON data error!")
            return
        }
        let mockedSession = MockedSession(data: data,
                                          response: nil,
                                          error: nil) { request in
            XCTAssertEqual("www.sample.com/apps", request.url?.absoluteString)
        }

        BuddyService(configuration: configure(session: mockedSession))
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
    
    func testBuddyServiceShouldSuccess() {
        guard let data = JSONMock.loadJson(fromResource: "builds_list") else {
            XCTFail("JSON data error!")
            return
        }
        let mockedSession = MockedSession.simulate(success: data) { request in
            XCTAssertEqual("www.sample.com/apps/999/builds?status=success&limit=5", request.url?.absoluteString)
        }
        
        BuddyService(configuration: configure(session: mockedSession))
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
    
    func testBuddyServiceShouldFail() {
        let mockedSession = MockedSession.simulate(failure: MockedSessionError.invalidResponse) { request in
            XCTAssertEqual("www.sample.com/apps/999/builds?status=success&limit=5", request.url?.absoluteString)
        }
        
        BuddyService(configuration: configure(session: mockedSession))
            .getBuilds(appId: "999",
                       size: 5,
                       status: .success,
                       completion: { result in
                        switch result {
                        case .success(_):
                            XCTFail("Should be fail! Got success.")
                        case .failure(let error):
                            guard case MockedSessionError.invalidResponse = error else {
                                XCTFail("Unexpected error!")
                                return
                            }
                        }
            })
    }
}


