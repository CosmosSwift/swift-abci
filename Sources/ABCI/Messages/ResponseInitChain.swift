// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  ResponseInitChain.swift last updated 02/06/2020
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

extension Types_ResponseInitChain {
    init(_ r: ResponseInitChain) {
        consensusParams = Types_ConsensusParams(r.consensusParams)
        validators = r.validators.map { Types_ValidatorUpdate($0) }
    }
}
