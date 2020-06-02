// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  Proof.swift last updated 02/06/2020
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

public class Proof {
    public let ops: [ProofOp]
    public init(ops: [ProofOp]) {
        self.ops = ops
    }
}

extension Merkle_Proof {
    init(_ p: Proof) {
        ops = p.ops.map { Merkle_ProofOp($0) }
    }
}
