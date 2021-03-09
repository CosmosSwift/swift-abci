// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  ResponseApplySnapshotChunk.swift last updated 16/07/2020
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
public struct ResponseApplySnapshotChunk {
    public enum Result {
      /// Unknown result, abort all snapshot restoration.
      case unknown
      /// The chunk was accepted.
      case accept
      /// Abort snapshot restoration, and don't try any other snapshots.
      case abort
      /// Reapply this chunk, combine with `refetchChunks` and `rejectSenders` as appropriate.
      case retry
      /// Restart this snapshot from `OfferSnapshot`, reusing chunks unless instructed otherwise.
      case retrySnapshot
      /// Reject this snapshot, try a different one.
      case rejectSnapshot
    }
    
    /// The result of applying this chunk.
    public let result: Result
    
    /// Refetch and reapply the given chunks, regardless of Result.
    /// Only the listed chunks will be refetched, and reapplied in sequential order.
    public let refetchChunks: [UInt32]
    
    /// Reject the given P2P senders, regardless of Result.
    /// Any chunks already applied will not be refetched unless explicitly requested,
    /// but queued chunks from these senders will be discarded, and new chunks or other snapshots rejected.
    public let rejectSenders: [String]
    
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
    ///
    /// - Parameters:
    ///   - result: The result of applying this chunk.
    ///   - refetchChunks: Refetch and reapply the given chunks, regardless of Result. Only the listed chunks will be refetched, and reapplied in sequential order=.
    ///   - rejectSenders: Reject the given P2P senders, regardless of Result. Any chunks already applied will not be refetched unless explicitly requested, but queued chunks from these senders will be discarded, and new chunks or other snapshots rejected.
    public init(
        result: Result = .unknown,
        refetchChunks: [UInt32] = [],
        rejectSenders: [String] = []
    ) {
        self.result = result
        self.refetchChunks = refetchChunks
        self.rejectSenders = rejectSenders
    }
}
