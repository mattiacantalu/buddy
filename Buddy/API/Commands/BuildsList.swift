import Foundation

extension BuddyService {
    func getBuilds(appId: String,
                   completion: @escaping ((Result<[BuildResponse]>) -> Void)) {
        let url = baseURL?
            .appendingPathComponent(Constants.URL.apps)
            .appendingPathComponent(appId)
            .appendingPathComponent(Constants.URL.builds)

        performTry({ try self.makeRequest(url,
                                          map: [BuildResponse].self,
                                          completion: completion) })
    }
}
