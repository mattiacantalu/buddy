import Foundation

extension BuddyService {
    func getBuilds(appId: String,
                   size: Int = 10,
                   completion: @escaping ((Result<[BuildResponse]>) -> Void)) {
        
        let url = baseURL?
            .appendingPathComponent(Constants.URL.apps)
            .appendingPathComponent(appId)
            .appendingPathComponent(Constants.URL.builds)
        
        performTry({ try self.makeRequest(url?.appending(params: [Constants.URL.status: Constants.URL.statusSuccess,
                                                                  Constants.URL.limit: size.stringValue]),
                                          map: [BuildResponse].self,
                                          completion: completion) })
    }
}
