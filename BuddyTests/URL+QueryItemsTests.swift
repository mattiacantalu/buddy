import XCTest
@testable import Buddy

final class URLQueryItemsTests: XCTestCase {

        func testAppendingNilParams() {
            do {
                let url = try URL(string: "fa-ke.com")?.appending(params: nil)
                XCTAssertEqual(url?.absoluteString, "fa-ke.com")
            } catch {
                XCTFail("Could not create URL!")
            }
        }

        func testAppendingParamWithNilValue() {
            do {
                let url = try URL(string: "fa-ke.com")?.appending(params: ["locale": nil])
                XCTAssertEqual(url?.absoluteString, "fa-ke.com")
            } catch {
                XCTFail("Could not create URL!")
            }
        }

        func testAppendingSingleParam() {
            do {
                let url = try URL(string: "fa-ke.com")?.appending(params: ["locale": "en_US"])
                XCTAssertEqual(url?.absoluteString, "fa-ke.com?locale=en_US")
            } catch {
                XCTFail("Could not create URL!")
            }
        }

        func testAppendingMultipleParamsWhereOneIsNil() {
            do {
                let url = try URL(string: "fa-ke.com")?.appending(params: ["locale": "en_US", "langId": nil])
                XCTAssertEqual(url?.absoluteString, "fa-ke.com?locale=en_US")
            } catch {
                XCTFail("Could not create URL!")
            }
        }

        func testAppendingEmptyParam() {
            do {
                let url = try URL(string: "fa-ke.com")?.appending(params: [:])
                XCTAssertEqual(url?.absoluteString, "fa-ke.com")
            } catch {
                XCTFail("Could not create URL!")
            }
        }
}
