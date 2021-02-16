import Foundation

public protocol RequestWrapper: Codable {
    var method: Method { get }
}
