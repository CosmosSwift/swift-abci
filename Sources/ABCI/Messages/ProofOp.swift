// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  ProofOp.swift last updated 02/06/2020
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

public class ProofOp {
    public let type: String
    public let key: Data
    public let data: Data

    public init(type: String, key: Data, data: Data) {
        self.type = type
        self.key = key
        self.data = data
    }
}

extension Merkle_ProofOp {
    init(_ p: ProofOp) {
        type = p.type
        key = p.key
        data = p.data
    }
}
