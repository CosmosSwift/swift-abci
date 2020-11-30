// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  ResponseInfo.swift last updated 16/07/2020
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

public struct RequestInitChain {
    /// Genesis time.
    public let time: Date
    /// ID of the blockchain.
    public let chainId: String
    /// Initial consensus-critical parameters.
    public let consensusParams: ConsensusParams
    /// Initial genesis validators, sorted by voting power.
    public let validators: [ValidatorUpdate]
    /// Serialized initial application state.
    public let appStateBytes: Data
}

extension RequestInitChain {
    init(_ request: Tendermint_Abci_RequestInitChain) {
        self.time = request.time.date
        self.chainId = request.chainID
        self.consensusParams = ConsensusParams(request.consensusParams)
        self.validators = request.validators.map(ValidatorUpdate.init)
        self.appStateBytes = request.appStateBytes
    }
}
