// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  ValidatorUpdate.swift last updated 16/07/2020
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

import Foundation

public struct ValidatorUpdate {
    public var publicKey: PublicKey
    public var power: Int64

    public init(publicKey: PublicKey, power: Int64) {
        self.publicKey = publicKey
        self.power = power
    }
}

extension ValidatorUpdate: Equatable, Comparable {
    public static func < (lhs: ValidatorUpdate, rhs: ValidatorUpdate) -> Bool {
        let lhsHex = lhs.publicKey.data?.hexEncodedString() ?? ""
        let rhsHex = rhs.publicKey.data?.hexEncodedString() ?? ""
        return lhsHex.compare(rhsHex) == .orderedAscending
    }
}

