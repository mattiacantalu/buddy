import Foundation

final class JSONMock {

    static func loadJson(fromResource resource: String, ofType type: String = "json") -> Any? {
        do {
            guard let mockData = JSONMock.loadData(fromResource: resource, ofType: type) else {
                return nil
            }
            return try JSONSerialization.jsonObject(with: mockData, options: [])
        } catch {
            return nil
        }
    }

    private static func loadData(fromResource resource: String, ofType type: String = "json") -> Data? {
        guard let path = Bundle(for: JSONMock.self).path(forResource: resource, ofType: type) else {
            return nil
        }
        do {
            return try Data(contentsOf: URL(fileURLWithPath: path))
        } catch {
            return nil
        }
    }
}
