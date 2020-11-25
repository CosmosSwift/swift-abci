// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  ProofOps.swift last updated 16/07/2020
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

public struct ProofOps {
    public let ops: [ProofOp]

    public init(ops: [ProofOp] = []) {
        self.ops = ops
    }
}

extension Tendermint_Crypto_ProofOps {
    init(_ proofOps: ProofOps) {
        self.ops = proofOps.ops.map(Tendermint_Crypto_ProofOp.init)
    }
}
