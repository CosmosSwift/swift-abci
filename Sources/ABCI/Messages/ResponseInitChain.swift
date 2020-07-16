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

public class ResponseInitChain {
    public let consensusParams: ConsensusParams
    public let validators: [ValidatorUpdate]

    public init(_ consensusParams: ConsensusParams, _ validators: [ValidatorUpdate]) {
        self.consensusParams = consensusParams
        self.validators = validators
    }
}

extension Tendermint_Abci_Types_ResponseInitChain {
    init(_ r: ResponseInitChain) {
        consensusParams = Tendermint_Abci_Types_ConsensusParams(r.consensusParams)
        validators = r.validators.map { Tendermint_Abci_Types_ValidatorUpdate($0) }
    }
}
