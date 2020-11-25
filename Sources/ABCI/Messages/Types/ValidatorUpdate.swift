// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  ValidatorUpdate.swift last updated 16/07/2020
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

public struct ValidatorUpdate {
    public let pubKey: PublicKey
    public let power: Int64

    public init(_ pubKey: PublicKey, _ power: Int64) {
        self.pubKey = pubKey
        self.power = power
    }
}

extension ValidatorUpdate {
    init(_ validatorUpdate: Tendermint_Abci_ValidatorUpdate) {
        self.pubKey = PublicKey(validatorUpdate.pubKey)
        self.power = validatorUpdate.power
    }
}

extension Tendermint_Abci_ValidatorUpdate {
    init(_ validatorUpdate: ValidatorUpdate) {
        self.power = validatorUpdate.power
        self.pubKey = Tendermint_Crypto_PublicKey(validatorUpdate.pubKey)
    }
}
