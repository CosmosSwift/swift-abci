// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  Proof.swift last updated 16/07/2020
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

public class Proof {
    public let total: Int64
    public let index: Int64
    public let leafHash: Data
    public let aunts: [Data]
    public init(total: Int64, index: Int64, leafHash: Data, aunts: [Data]) {
        self.total = total
        self.index = index
        self.leafHash = leafHash
        self.aunts = aunts
    }
}

extension Tendermint_Crypto_Merkle_Proof {
    init(_ p: Proof) {
        total = p.total
        index = p.index
        leafHash = p.leafHash
        aunts = p.aunts
    }
}
