//
//  ResponseSerializer.swift
//  ABCISwift
//


import Foundation
import Core
import Venice
import SwiftProtobuf

internal final class ResponseSerializer : Serializer {
    internal func serialize(_ response: Types_Response, deadline: Deadline) throws {
        let message = try response.serializedData()
        var array = [UInt8]()
        // varint size encoding representation (https://developers.google.com/protocol-buffers/docs/encoding#varints)
        var toEncode = message.count << 1 // >0 zig-zag representation (https://developers.google.com/protocol-buffers/docs/encoding?csw=1#signed-integers)
        while (toEncode != 0) {
            var res = toEncode & 127 // 7 least significant bits
            toEncode = toEncode >> 7 // shift by 7 bits
            if (toEncode != 0) {
                res += 128
            }
            array.insert(UInt8(res), at: 0)
        }
        let d = Data(bytes:array)
        try stream.write(d, deadline: deadline)
        try stream.write(message, deadline: deadline)
        
    }
}
