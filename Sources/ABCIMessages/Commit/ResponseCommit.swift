// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  ResponseCommit.swift last updated 16/07/2020
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

/// Persists the application state.
///
/// Optionally return a Merkle root hash of the applications state.
/// `ResponseCommit.data` is included as the `Header.appHash` in the next block.
/// Later calls to `Query` can return proofs about the application state anchored in this Merkle root hash
///
/// NOTICE:
/// - Developers can return whatever they want here (nothing, a constant string, etc.), so long as it is deterministic
/// It must be a function of what came from `BeginBlock`, `DeliverTx` and `EndBlock` messages.
/// Use `ResponseCommit.retainHeight` with caution. If all nodes in the network remove historical blocks then data is permanently lost,
/// and no new node will be able to join the network and bootstrap. Historical blocks may also be required for other purposes, e.g. auditing,
/// replay of non-persisted heights, light client verification and so on.
public struct ResponseCommit {
    /// The Merkle root hash of the application state.
    public let data: Data
    /// Blocks below this height may be removed.
    public let retainHeight: Int64

    /// Persists the application state.
    ///
    /// Optionally return a Merkle root hash of the applications state.
    /// `ResponseCommit.data` is included as the `Header.appHash` in the next block.
    /// Later calls to `Query` can return proofs about the application state anchored in this Merkle root hash
    ///
    /// NOTICE:
    /// - Developers can return whatever they want here (nothing, a constant string, etc.), so long as it is deterministic
    /// It must be a function of what came from `BeginBlock`, `DeliverTx` and `EndBlock` messages.
    /// Use `ResponseCommit.retainHeight` with caution. If all nodes in the network remove historical blocks then data is permanently lost,
    /// and no new node will be able to join the network and bootstrap. Historical blocks may also be required for other purposes, e.g. auditing,
    /// replay of non-persisted heights, light client verification and so on.
    /// - Parameters:
    ///   - data: The Merkle root hash of the application state. Defaults to an empty `Data` value.
    ///   - retainHeight: Blocks below this height may be removed. Defaults to `0`.
    public init(
        data: Data = Data(),
        retainHeight: Int64 = 0
    ) {
        self.data = data
        self.retainHeight = retainHeight
    }
}
