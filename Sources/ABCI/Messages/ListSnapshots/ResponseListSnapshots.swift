// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  ResponseListSnapshots.swift last updated 16/07/2020
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

/// Used during state sync to discover available snapshots on peers.
public struct ResponseListSnapshots {
    /// List of local state snapshots.
    public let snapshots: [Snapshot]
    
    /// Used during state sync to discover available snapshots on peers.
    /// - Parameter snapshots: List of local state snapshots.
    public init(snapshots: [Snapshot] = []) {
        self.snapshots = snapshots
    }
}

extension Tendermint_Abci_ResponseListSnapshots {
    init(_ response: ResponseListSnapshots) {
        self.snapshots = response.snapshots.map(Tendermint_Abci_Snapshot.init)
    }
}
