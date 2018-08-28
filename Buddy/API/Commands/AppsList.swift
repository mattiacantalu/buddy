import Foundation

extension BuddyService {
    func getApps(completion: @escaping ((Result<[AppResponse]>) -> Void)) {
        let url = baseURL?.appendingPathComponent("apps")

        performTry({ try self.makeRequest(url,
                                          map: [AppResponse].self,
                                          completion: completion) })
    }
}
