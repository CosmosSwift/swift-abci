// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  BlockParams.swift last updated 02/06/2020
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

public class BlockParams {
    public let maxBytes: Int64
    public let maxGas: Int64

    public init(maxBytes: Int64, maxGas: Int64) {
        self.maxBytes = maxBytes
        self.maxGas = maxGas
    }
}

extension Types_BlockParams {
    init(_ b: BlockParams) {
        maxBytes = b.maxBytes
        maxGas = b.maxGas
    }
}
