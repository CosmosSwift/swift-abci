// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  DataConvertible.swift last updated 16/07/2020
//
//  Copyright © 2020 Katalysis B.V. and the CosmosSwift project authors.
//  Licensed under Apache License v2.0
//
//  See LICENSE.txt for license information
//  See CONTRIBUTORS.txt for the list of CosmosSwift project authors
//
//  SPDX-License-Identifier: Apache-2.0
//
// ===----------------------------------------------------------------------===

// taken from answer to https://stackoverflow.com/questions/38023838/round-trip-swift-number-types-to-from-data
// by https://stackoverflow.com/users/1187415/martin-r

import Foundation

public protocol DataConvertible {
    init?(data: Data)
    var data: Data { get }
}

extension DataConvertible {
    public init?(data: Data) {
        guard data.count == MemoryLayout<Self>.size else {
            return nil
        }
        
        self = data.withUnsafeBytes({ $0.load(as: Self.self) })
    }

    public var data: Data {
        Swift.withUnsafeBytes(of: self, { Data($0) })
    }
}

extension Int: DataConvertible {}
extension Int8: DataConvertible {}
extension Int16: DataConvertible {}
extension Int32: DataConvertible {}
extension Int64: DataConvertible {}
extension UInt: DataConvertible {}
extension UInt8: DataConvertible {}
extension UInt16: DataConvertible {}
extension UInt32: DataConvertible {}
extension UInt64: DataConvertible {}
extension Float: DataConvertible {}
extension Double: DataConvertible {}

extension String: DataConvertible {
    public init?(data: Data) {
        self.init(data: data, encoding: .utf8)
    }

    public var data: Data {
        // Note: a conversion to UTF-8 cannot fail.
        return self.data(using: .utf8)!
    }
}

extension Data: DataConvertible {
    public init?(data: Data) {
        self = data
    }

    public var data: Data { self }
}
