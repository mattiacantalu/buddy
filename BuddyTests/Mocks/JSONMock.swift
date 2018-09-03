import Foundation

final class JSONMock {

    static func loadJson(fromResource resource: String, ofType type: String = "json") -> Data? {
            return JSONMock.loadData(fromResource: resource, ofType: type)
    }

    private static func loadData(fromResource resource: String, ofType type: String = "json") -> Data? {
        guard let path = Bundle(for: JSONMock.self).path(forResource: resource, ofType: type) else {
            return nil
        }
        do {
            return try Data(contentsOf: URL(fileURLWithPath: path))
        } catch let e {
            print(e)
            return nil
        }
    }
}
