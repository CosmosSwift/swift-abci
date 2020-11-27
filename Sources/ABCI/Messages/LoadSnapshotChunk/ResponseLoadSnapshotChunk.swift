// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  ResponseLoadSnapshotChunk.swift last updated 16/07/2020
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

/// Used during state sync to retrieve snapshot chunks from peers.
public struct ResponseLoadSnapshotChunk {
    /// The binary chunk contents, in an arbitray format.
    /// Chunk messages cannot be larger than 16 MB including metadata, so 10 MB is a good starting point.
    public let chunk: Data
    
    /// Used during state sync to retrieve snapshot chunks from peers.
    ///
    /// - Parameter chunk: The binary chunk contents, in an arbitray format. Chunk messages cannot be larger than 16 MB including metadata, so 10 MB is a good starting point.
    public init(chunk: Data = Data()) {
        self.chunk = chunk
    }
}

extension Tendermint_Abci_ResponseLoadSnapshotChunk {
    init(_ response: ResponseLoadSnapshotChunk) {
        self.chunk = response.chunk
    }
}
