import Foundation

extension BuddyService {
    func getBuilds(appId: String,
                   limitTo limit: Int = Constants.URL.limitValue,
                   completion: @escaping ((Result<[BuildResponse]>) -> Void)) {
        
        let url = baseURL?
            .appendingPathComponent(Constants.URL.apps)
            .appendingPathComponent(appId)
            .appendingPathComponent(Constants.URL.builds)
        
        performTry({ try self.makeRequest(url?.appending(params: [Constants.URL.status: Constants.URL.statusSuccess,
                                                                  Constants.URL.limit: limit.stringValue]),
                                          map: [BuildResponse].self,
                                          completion: completion) })
    }
}
