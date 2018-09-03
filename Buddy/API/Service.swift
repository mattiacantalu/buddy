import Foundation

protocol ServiceProtocol {
    func performTask(with request: URLRequest,
                     completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

struct Service: ServiceProtocol {
    private let session: URLSession
    private let dispatcher: Dispatcher

    init(session: URLSession = URLSession.shared,
         dispatcher: Dispatcher = DefaultDispatcher()) {
        self.session = session
        self.dispatcher = dispatcher
    }

    func performTask(with request: URLRequest,
                     completion: @escaping (Data?, URLResponse?, Error?) -> Void) {

        let task = session.dataTask(with: request) { (responseData, urlResponse, responseError) in
            self.dispatcher.dispatch {
                completion(responseData, urlResponse, responseError)
            }
        }

        task.resume()
    }
}
