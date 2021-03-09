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
    public let chainID: String
    /// Initial consensus-critical parameters.
    public let consensusParams: ConsensusParams
    /// Initial genesis validators, sorted by voting power.
    public var validators: [ValidatorUpdate]
    /// Serialized initial application state.
    public let appStateBytes: Data
    
    public init(time: Date, chainID: String, consensusParams: ConsensusParams, validators: [ValidatorUpdate], appStateBytes: Data) {
        self.time = time
        self.chainID = chainID
        self.consensusParams = consensusParams
        self.validators = validators
        self.appStateBytes = appStateBytes
    }
}
