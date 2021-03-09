// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  ResponseEndBlock.swift last updated 16/07/2020
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

public struct ResponseEndBlock {
    /// Changes to the validator set. Set voting power to `0` to remove a validator from the validator set.
    public let updates: [ValidatorUpdate]
    /// Changes to consensus-critical time, size and other parameters.
    public let consensusUpdates: ConsensusParams
    /// Type and Key-Value events for indexing.
    public let events: [Event]

    /// Signals the end of a block.
    ///
    /// Called after all transactions, prior to `Commit`.
    /// Validator updates returned by block `H` impact blocks `H+1`, `H+2` and `H+3`, but only
    /// affects changes on the validator set of `H+2`:
    /// - `H+1`: `nextValidatorHash`.
    /// - `H+2`: `validatorHash` and thus the validator set.
    /// - `H+3`: `lastCommitInfo` ie. the last validator set.
    /// Consensus params returned for block `H` apply for block `H+1`.
    /// - Parameters:
    ///   - updates: Changes to the validator set. Set voting power to `0` to remove a validator from the validator set. Defaults to an empty array.
    ///   - consensusUpdates: Changes to consensus-critical time, size and other parameters. This parameter is optional.
    ///   - events: Type and Key-Value events for indexing. Defaults to an empty array.
    public init(
        updates: [ValidatorUpdate] = [],
        consensusUpdates: ConsensusParams = ConsensusParams(),
        events: [Event] = []
    ) {
        self.updates = updates
        self.consensusUpdates = consensusUpdates
        self.events = events
    }
}
