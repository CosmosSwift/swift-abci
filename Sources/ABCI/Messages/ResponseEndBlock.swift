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

public class ResponseEndBlock {
    public let updates: [ValidatorUpdate]
    public let consensusUpdates: ConsensusParams
    public let events: [Event]

    public init(updates: [ValidatorUpdate], consensusUpdates: ConsensusParams, events: [Event]) {
        self.updates = updates
        self.consensusUpdates = consensusUpdates
        self.events = events
    }
}

extension Tendermint_Abci_Types_ResponseEndBlock {
    init(_ r: ResponseEndBlock) {
        validatorUpdates = r.updates.map { Tendermint_Abci_Types_ValidatorUpdate($0) }
        consensusParamUpdates = Tendermint_Abci_Types_ConsensusParams(r.consensusUpdates)
        events = r.events.map { Tendermint_Abci_Types_Event($0) }
    }
}
