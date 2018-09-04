import Foundation

extension URL {
    public func appending(params: [String: String?]?) throws -> URL {
        let items: [URLQueryItem]? = params?
            .lazy
            .filter({ $0.value != nil })
            .map({ URLQueryItem(name: $0.key, value: $0.value) })
        
        guard let queryItems = items, queryItems.count > 0 else {
            return self
        }
        
        guard let url = URLComponents(url: self,
                                      resolvingAgainstBaseURL: false)?
            .appending(items: queryItems).url else {
                return self
        }
        
        return url
    }
}

private extension URLComponents {
    func appending(items: [URLQueryItem]) -> URLComponents {
        var components = self
        components.queryItems = components.queryItems ?? [URLQueryItem]()
        components.queryItems? += items
        
        return components
    }
}

