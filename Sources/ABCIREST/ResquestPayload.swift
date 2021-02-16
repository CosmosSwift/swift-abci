public protocol RequestPayload: Codable {
    associatedtype ResponsePayload: Codable
    static var method: Method { get }
    var path: String { get }
}
