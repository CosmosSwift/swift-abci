

import Foundation


public struct StringRepresentedInt<IntegerType: FixedWidthInteger>: Hashable, Equatable, Comparable {
    public static func < (lhs: StringRepresentedInt<IntegerType>, rhs: StringRepresentedInt<IntegerType>) -> Bool {
        lhs.value < rhs.value
    }
    
    fileprivate let value: IntegerType

    public init(_ int: IntegerType) {
        self.value = int
    }
    
    public init?(string: String) {
        guard let value = IntegerType(string) else {
            return nil
        }
        self.value = value
    }
}

extension StringRepresentedInt: CustomStringConvertible {
    public var description: String {
        "\(self.value)"
    }
}
//
//extension StringRepresentedInt: ExpressibleByIntegerLiteral where IntegerType: ExpressibleByIntegerLiteral {
//    public typealias IntegerLiteralType = IntegerType
//    public init(integerLiteral value: IntegerType) {
//        self.value = IntegerType(value)
//    }
//}

struct ConversionError: Error {
    
}

extension StringRepresentedInt: Codable {
    public init(from decoder: Decoder) throws {

        let container = try decoder.singleValueContainer()
        let strValue = try container.decode(String.self)
        guard let value = IntegerType(strValue) else {
            throw ConversionError()
        }
        self.value = value
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode("\(self.value)")
    }

}

extension FixedWidthInteger {
    public init(_ stringRepresentedInt: StringRepresentedInt<Self>) {
        self = stringRepresentedInt.value
    }
}
