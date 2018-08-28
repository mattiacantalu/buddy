import Foundation

enum BuddyError: Error {
    case responseError
    case noData
    case wrongUrl
}

extension BuddyError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .responseError:
            return "An error has occurred"
        case .noData:
            return "No data fetched"
        case .wrongUrl:
            return "Unexpected URL creation exception"
        }
    }
}
