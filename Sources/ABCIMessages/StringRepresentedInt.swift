import Foundation
import CodableWrappers

public struct IntToStringCoder<Value: FixedWidthInteger & Codable>: StaticCoder {
    public static func decode(from decoder: Decoder) throws -> Value {
        let stringValue = try String(from: decoder)

        guard let value = Value(stringValue) else {
            throw DecodingError.valueNotFound(
                self,
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Expected \(Int.self)) but could not convert \(stringValue) to \(Int.self)"
                )
            )
        }
        return value
    }

    public static func encode(value: Value, to encoder: Encoder) throws {
        try String(value).encode(to: encoder)
    }
}

public typealias StringBackedInt<T: FixedWidthInteger & Codable> = CodingUses<IntToStringCoder<T>>
public typealias OptionalStringBackedInt<T: FixedWidthInteger & Codable> = OptionalCoding<StringBackedInt<T>>
