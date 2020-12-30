// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  ResponseInitChain.swift last updated 16/07/2020
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
 
/// Initializes the chain.
///
/// This allows the app to decide if it wants to accept the initial validator set proposed by tendermint
/// (ie. in the genesis file), or if it wants to use a different one, perhaps computed based on some
/// application specific information in the genesis file.
///
/// NOTICE:
/// - Called only once usually at genesis or when the block height is 0.
/// - If `ResponseInitChain.validators` is empty, the initial validator set will be `RequestInitChain.validators`.
/// - If `ResponseInitChainQuery.validators` is not empty, it will be the initial validator set regardless of what is in `RequestInitChain.validators`.
public struct ResponseInitChain {
    /// Initial consensus-critical parameters.
    public let consensusParams: ConsensusParams
    /// Initial validator set.
    public var validators: [ValidatorUpdate]

    /// Initializes the chain.
    ///
    /// This allows the app to decide if it wants to accept the initial validator set proposed by tendermint
    /// (ie. in the genesis file), or if it wants to use a different one, perhaps computed based on some
    /// application specific information in the genesis file.
    ///
    /// NOTICE:
    /// - Called only once usually at genesis or when the block height is 0.
    /// - If `ResponseInitChain.validators` is empty, the initial validator set will be `RequestInitChain.validators`.
    /// - If `ResponseInitChainQuery.validators` is not empty, it will be the initial validator set regardless of what is in `RequestInitChain.validators`.
    /// - Parameters:
    ///   - consensusParams: Initial consensus-critical parameters. This parameter is optional.
    ///   - validators: Initial validator set. This parameter is optional.
    public init(
        consensusParams: ConsensusParams = ConsensusParams(),
        validators: [ValidatorUpdate] = []
    ) {
        self.consensusParams = consensusParams
        self.validators = validators
    }
}

extension Tendermint_Abci_ResponseInitChain {
    init(_ response: ResponseInitChain) {
        self.consensusParams = Tendermint_Abci_ConsensusParams(response.consensusParams)
        self.validators = response.validators.map(Tendermint_Abci_ValidatorUpdate.init)
    }
}
