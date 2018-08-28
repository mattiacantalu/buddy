import Foundation

enum Result<Value> {
    case success(Value)
    case failure(Error)
}

struct BuddyService {
    private let configuration: Configuration
    var baseURL: URL? {
        return URL(string: configuration.urlString)
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
        request.setValue("Bearer \(configuration.token)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { (responseData, urlResponse, responseError) in
            DispatchQueue.main.async {
                completion(self.decode(response: responseData,
                                       map: map,
                                       error: responseError))
            }
        }

        task.resume()
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



