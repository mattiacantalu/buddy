import Foundation

extension BuddyService {
    func getBuild(number: String,
                  completion: @escaping ((Result<BuildResponse>) -> Void)) {
        let url = baseURL?
            .appendingPathComponent(Constants.URL.builds)
            .appendingPathComponent(number)

        performTry({ try self.makeRequest(url,
                                          map: BuildResponse.self,
                                          completion: completion) })
    }
}
