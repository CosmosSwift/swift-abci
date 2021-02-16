// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  Snapshot.swift last updated 16/07/2020
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

/// Used for state sync snapshots.
///
/// A snapshot is considered identical across nodes only if all fields are equal (including `metadata`).
/// Chunks may be retrieved from all nodes that have the same snapshot.
///
/// When sent across the network, a snapshot message can be at most 4 MB.
public struct Snapshot {
    /// The height at which the snapshot was taken (after commit).
    public let height: UInt64

    /// The application-specific snapshot format, allowing applications to version their snapshot data format and make backwards-incompatible changes. Tendermint does not interpret this.
    public let format: UInt32

    /// The number of chunks in the snapshot. Must be at least 1 (even if empty).
    public let chunks: UInt32
    
    /// An arbitrary snapshot hash. Must be equal only for identical snapshots across nodes. Tendermint does not interpret the hash, it only compares them.
    public let hash: Data
    
    /// Arbitrary application metadata, for example chunk hashes or other verification data.
    public let metadata: Data
    
    /// Used for state sync snapshots.
    ///
    /// A snapshot is considered identical across nodes only if all fields are equal (including `metadata`).
    /// Chunks may be retrieved from all nodes that have the same snapshot.
    ///
    /// When sent across the network, a snapshot message can be at most 4 MB.
    ///
    /// - Parameters:
    ///   - height: The height at which the snapshot was taken (after commit).
    ///   - format: The application-specific snapshot format, allowing applications to version their snapshot data format and make backwards-incompatible changes. Tendermint does not interpret this.
    ///   - chunks: The number of chunks in the snapshot. Must be at least 1 (even if empty).
    ///   - hash: An arbitrary snapshot hash. Must be equal only for identical snapshots across nodes. Tendermint does not interpret the hash, it only compares them.
    ///   - metadata: Arbitrary application metadata, for example chunk hashes or other verification data.
    public init(
        height: UInt64 = 0,
        format: UInt32 = 0,
        chunks: UInt32 = 0,
        hash: Data = Data(),
        metadata: Data = Data()
    ) {
        self.height = height
        self.format = format
        self.chunks = chunks
        self.hash = hash
        self.metadata = metadata
    }
}
