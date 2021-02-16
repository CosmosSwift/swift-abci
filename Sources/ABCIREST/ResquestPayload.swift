import DataConvertible

public protocol RequestPayload: Codable, DataConvertible {
    associatedtype ResponsePayload: Codable, DataConvertible
    static var method: Method { get }
    var path: String { get }
}
