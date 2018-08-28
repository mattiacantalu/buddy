import Foundation

extension BuddyService {
    func getBuilds(appId: String,
                   completion: @escaping ((Result<[BuildResponse]>) -> Void)) {
        let url = baseURL?
            .appendingPathComponent("apps")
            .appendingPathComponent(appId)
            .appendingPathComponent("builds")

        performTry({ try self.makeRequest(url,
                                          map: [BuildResponse].self,
                                          completion: completion) })
    }
}
