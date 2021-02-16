// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  ResponseOfferSnapshot.swift last updated 16/07/2020
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

/// `OfferSnapshot` is called when bootstrapping a node using state sync.
/// The application may accept or reject snapshots as appropriate.
/// Upon accepting, Tendermint will retrieve and apply snapshot chunks via `ApplySnapshotChunk`.
/// The application may also choose to reject a snapshot in the chunk response,
/// in which case it should be prepared to accept further `OfferSnapshot` calls.
///
/// Only `appHash` can be trusted, as it has been verified by the light client.
/// Any other data can be spoofed by adversaries, so applications should employ
/// additional verification schemes to avoid denial-of-service attacks.
/// The verified `appHash` is automatically checked against the restored application
/// at the end of snapshot restoration.
public struct ResponseOfferSnapshot {
    public enum Result {
      /// Unknown result, abort all snapshot restoration.
      case unknown
      /// Snapshot accepted, apply chunks.
      case accept
      /// Abort all snapshot restoration.
      case abort
      /// Reject this specific snapshot, try others.
      case reject
      /// Reject all snapshots of this `format`, try others.
      case rejectFormat
      /// Reject all snapshots from the sender(s), try others.
      case rejectSender
    }
    
    /// The result of the snapshot offer.
    public let result: Result
    
    /// `OfferSnapshot` is called when bootstrapping a node using state sync.
    /// The application may accept or reject snapshots as appropriate.
    /// Upon accepting, Tendermint will retrieve and apply snapshot chunks via `ApplySnapshotChunk`.
    /// The application may also choose to reject a snapshot in the chunk response,
    /// in which case it should be prepared to accept further `OfferSnapshot` calls.
    ///
    /// Only `appHash` can be trusted, as it has been verified by the light client.
    /// Any other data can be spoofed by adversaries, so applications should employ
    /// additional verification schemes to avoid denial-of-service attacks.
    /// The verified `appHash` is automatically checked against the restored application
    /// at the end of snapshot restoration.
    ///
    /// - Parameter result: The result of the snapshot offer.
    public init(result: Result = .unknown) {
        self.result = result
    }
}
