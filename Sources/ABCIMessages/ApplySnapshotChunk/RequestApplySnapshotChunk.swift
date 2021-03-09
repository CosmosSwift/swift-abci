// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  RequestApplySnapshotChunk.swift last updated 16/07/2020
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

/// The application can choose to refetch chunks and/or ban P2P peers as appropriate.
/// Tendermint will not do this unless instructed by the application.
///
/// The application may want to verify each chunk, e.g. by attaching chunk hashes in `Snapshot.
/// metadata` and/or incrementally verifying contents against `appHash`.
///
/// When all chunks have been accepted, Tendermint will make an ABCI `Info` call to verify that
/// `lastBlockAppHash` and `lastBlockHeight` matches the expected values, and record the `appVersion`
/// in the node state. It then switches to fast sync or consensus and joins the network.
///
/// If Tendermint is unable to retrieve the next chunk after some time
/// (e.g. because no suitable peers are available), it will reject the snapshot
/// and try a different one via `OfferSnapshot`. The application should be prepared
/// to reset and accept it or abort as appropriate.
public struct RequestApplySnapshotChunk {
    /// The chunk index, starting from 0. Tendermint applies chunks sequentially.
    public let index: UInt32
    
    /// The binary chunk contents, as returned by `loadSnapshotChunk`.
    public let chunk: Data
    
    /// The P2P ID of the node who sent this chunk.
    public let sender: String
    
    public init(index: UInt32, chunk: Data, sender: String) {
        self.index = index
        self.chunk = chunk
        self.sender = sender
    }
}
