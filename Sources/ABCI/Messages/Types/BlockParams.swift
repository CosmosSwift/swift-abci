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

public struct BlockParams: Codable {
    /// Maximum size of a block, in bytes.
    ///
    /// Note: Must be greater than zero.
    public let maxBytes: Int64
    /// Maximum sum of `GasWanted` in a proposed block.
    ///
    /// Note: Must be greater than or equal to -1. Blocks that violate `maxGas` may be committed if there are Byzantine proposers.
    /// It's the application's responsibility to handle this when processing a block!
    public let maxGas: Int64
    
    /// Initializes a instance of `BlockParams`
    ///
    /// - Parameters:
    ///   - maxBytes: Maximum size of a block, in bytes. Defaults to approximately 22 MB.
    ///   - maxGas: Maximum sum of `GasWanted` in a proposed block. Defaults to -1.
    public init(
        maxBytes: Int64 = 22_020_096,
        maxGas: Int64 = -1
    ) {
        self.maxBytes = maxBytes
        self.maxGas = maxGas
    }
}

extension BlockParams {
    init(_ blockParams: Tendermint_Abci_BlockParams) {
        self.maxBytes = blockParams.maxBytes
        self.maxGas = blockParams.maxGas
    }
}

extension Tendermint_Abci_BlockParams {
    init(_ blockParams: BlockParams) {
        self.maxBytes = blockParams.maxBytes
        self.maxGas = blockParams.maxGas
    }
}
