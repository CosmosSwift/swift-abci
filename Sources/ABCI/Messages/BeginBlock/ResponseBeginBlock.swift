// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  ResponseBeginBlock.swift last updated 16/07/2020
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

/// Signals the beginning of a new block.
///
/// NOTICE:
/// - Called prior to any `DeliverTx` message.
/// - The header contains the height, timestamp, and more - it exactly matches the Tendermint block header.
/// - `RequestBeginBlock.lastCommitInfo` and `RequestBeginBlock.byzantineValidators` can be used to determine rewards and punishments for the validators.
/// - Validators here do not include public keys.
public struct ResponseBeginBlock {
    /// Type and Key-Value events for indexing.
    public let events: [Event]
    
    /// Signals the beginning of a new block.
    ///
    /// NOTICE:
    /// - Called prior to any `DeliverTx` message.
    /// - The header contains the height, timestamp, and more - it exactly matches the Tendermint block header.
    /// - `RequestBeginBlock.lastCommitInfo` and `RequestBeginBlock.byzantineValidators` can be used to determine rewards and punishments for the validators.
    /// - Validators here do not include public keys.
    /// - Parameter events: Type and Key-Value events for indexing. Defaults to an empty array.
    public init(events: [Event] = []) {
        self.events = events
    }
}

extension Tendermint_Abci_ResponseBeginBlock {
    init(_ response: ResponseBeginBlock) {
        self.events = response.events.map(Tendermint_Abci_Event.init)
    }
}
