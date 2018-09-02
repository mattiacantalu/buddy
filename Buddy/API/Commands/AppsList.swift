import Foundation

extension BuddyService {
    func getApps(completion: @escaping ((Result<[AppResponse]>) -> Void)) {
        let url = baseURL?.appendingPathComponent(Constants.URL.apps)

        performTry({ try self.makeRequest(url,
                                          map: [AppResponse].self,
                                          completion: completion) })
    }
}
