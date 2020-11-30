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

public struct Proof {
    public let total: Int64
    public let index: Int64
    public let leafHash: Data
    public let aunts: [Data]
    
    public init(
        total: Int64 = 0,
        index: Int64 = 0,
        leafHash: Data = Data(),
        aunts: [Data] = []
    ) {
        self.total = total
        self.index = index
        self.leafHash = leafHash
        self.aunts = aunts
    }
}

extension Tendermint_Crypto_Proof {
    init(_ proof: Proof) {
        self.total = proof.total
        self.index = proof.index
        self.leafHash = proof.leafHash
        self.aunts = proof.aunts
    }
}
