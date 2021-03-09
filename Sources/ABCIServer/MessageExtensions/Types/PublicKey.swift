// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  PublicKey.swift last updated 02/06/2020
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

extension PublicKey {
    init(_ publicKey: Tendermint_Crypto_PublicKey) {
        switch publicKey.sum {
        case .ed25519(let data):
            self = .ed25519(data)
        case .secp256K1(let data):
            self = .secp256K1(data)
        case .none:
            self = .none
        }
    }
}

extension Tendermint_Crypto_PublicKey {
    init(_ publicKey: PublicKey) {
        switch publicKey {
        case .ed25519(let data):
            self.ed25519 = data
        case .secp256K1(let data):
            self.secp256K1 = data
        case .none:
            self.sum = .none
        }
    }
}
