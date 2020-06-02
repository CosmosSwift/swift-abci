// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  ValidatorUpdate.swift last updated 02/06/2020
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

public class ValidatorUpdate {
    public let pubKey: PubKey
    public let power: Int64

    public init(_ pubKey: PubKey, _ power: Int64) {
        self.pubKey = pubKey
        self.power = power
    }
}

extension ValidatorUpdate {
    convenience init(protobuf: Types_ValidatorUpdate) {
        self.init(PubKey(protobuf.pubKey.type, protobuf.pubKey.data), protobuf.power)
    }
}

extension Types_ValidatorUpdate {
    init(_ r: ValidatorUpdate) {
        power = r.power
        pubKey = Types_PubKey(r.pubKey)
    }
}
