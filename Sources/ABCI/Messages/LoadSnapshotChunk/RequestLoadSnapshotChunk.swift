// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  RequestLoadSnapshotChunk.swift last updated 16/07/2020
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
public struct RequestLoadSnapshotChunk {
    /// The height of the snapshot the chunks belongs to.
    public let height: UInt64
    
    /// The application-specific format of the snapshot the chunk belongs to.
    public let format: UInt32
    
    /// The chunk index, starting from 0 for the initial chunk.
    public let chunk: UInt32
}

extension RequestLoadSnapshotChunk {
    init(_ request: Tendermint_Abci_RequestLoadSnapshotChunk) {
        self.height = request.height
        self.format = request.format
        self.chunk = request.chunk
    }
}
