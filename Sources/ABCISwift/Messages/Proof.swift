//===----------------------------------------------------------------------===//
//
// This source file is part of the ABCISwift open source project
//
// Copyright (c) 2019 ABCISwift project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of ABCISwift project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

public class Proof {
    public let ops: [ProofOp]
    public init(ops: [ProofOp]) {
        self.ops = ops
    }
}

extension Merkle_Proof {
    init(_ p: Proof) {
        self.ops = p.ops.map{ Merkle_ProofOp($0) }
    }
}
