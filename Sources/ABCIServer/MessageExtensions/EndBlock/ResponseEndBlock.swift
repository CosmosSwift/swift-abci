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
import ABCIMessages

extension Tendermint_Abci_ResponseEndBlock {
    init(_ response: ResponseEndBlock) {
        self.validatorUpdates = response.updates.map(Tendermint_Abci_ValidatorUpdate.init)
        self.consensusParamUpdates = Tendermint_Abci_ConsensusParams(response.consensusUpdates)
        self.events = response.events.map(Tendermint_Abci_Event.init)
    }
}
