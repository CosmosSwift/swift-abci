// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  RequestOfferSnapshot.swift last updated 16/07/2020
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

public struct RequestOfferSnapshot {
    /// The snapshot offered for restoration.
    public let snapshot: Snapshot
    
    /// The light client-verified app hash for this height, from the blockchain.
    public let appHash: Data
    
    public init(snapshot: Snapshot, appHash: Data) {
        self.snapshot = snapshot
        self.appHash = appHash
    }
}
