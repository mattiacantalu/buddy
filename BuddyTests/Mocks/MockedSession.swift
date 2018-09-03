import Foundation
@testable import Buddy

struct MockedSession: SessionProtocol {
    let json: String

    func dataTask(with request: URLRequest,
                  completion: @escaping (Data?, URLResponse?, Error?) -> Void) {

        guard let url = request.url else {
            completion(nil, nil, MockedSessionError.badURL)
            return
        }

        let response = URLResponse(url: url,
                                   mimeType: nil,
                                   expectedContentLength: 0,
                                   textEncodingName: nil)

        guard let data = JSONMock.loadJson(fromResource: json) else {
            completion(nil, response, MockedSessionError.badJSON)
            return
        }

        completion(data, response, nil)
    }
}

enum MockedSessionError: Error {
    case badURL
    case badJSON
}
