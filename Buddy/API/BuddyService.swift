import Foundation

enum Result<Value> {
    case success(Value)
    case failure(Error)
}

struct BuddyService {
    private let configuration: Configuration

    var baseURL: URL? {
        return URL(string: configuration.baseUrl)
    }

    init(configuration: Configuration) {
        self.configuration = configuration
    }

    func makeRequest<T: Decodable>(_ url: URL?,
                                   map: T.Type,
                                   completion: @escaping ((Result<T>) -> Void)) throws {

        guard let url = url else {
            throw BuddyError.wrongUrl
        }

        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("\(Constants.URL.authHeaderValue) \(configuration.token)", forHTTPHeaderField: Constants.URL.authHeader)

        configuration.service.performTask(with: request) { (responseData, urlResponse, responseError) in
            completion(self.decode(response: responseData,
                                   map: map,
                                   error: responseError))
        }
    }

    private func decode<T: Decodable>(response: Data?,
                                      map: T.Type,
                                      error: Error?) -> (Result<T>) {
        if error != nil {
            return (.failure(BuddyError.responseError))
        }

        guard let jsonData = response else {
            return (.failure(BuddyError.noData))
        }

        do {
            let decoded = try JSONDecoder().decode(map,
                                                   from: jsonData)
            return (.success(decoded))
        } catch {
            return (.failure(error))
        }
    }
}



