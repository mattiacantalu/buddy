import Foundation

struct Configuration {
    let token: String
    let baseUrl: String
    let service: Service

    init(token: String,
         baseUrl: String,
         service: Service = Service()) {
        self.token = token
        self.baseUrl = baseUrl
        self.service = service
    }
}
