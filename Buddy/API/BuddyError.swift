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
            return Constants.Error.responseError
        case .noData:
            return Constants.Error.noData
        case .wrongUrl:
            return Constants.Error.wrongUrl
        }
    }
}
