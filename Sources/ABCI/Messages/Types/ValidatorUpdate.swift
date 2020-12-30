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

import Foundation

public struct ValidatorUpdate {
    public let publicKey: PublicKey
    public let power: Int64

    public init(publicKey: PublicKey, power: Int64) {
        self.publicKey = publicKey
        self.power = power
    }
}

extension ValidatorUpdate: Equatable, Comparable {
    public static func < (lhs: ValidatorUpdate, rhs: ValidatorUpdate) -> Bool {
        let lhsHex = lhs.publicKey.data?.hexEncodedString() ?? ""
        let rhsHex = rhs.publicKey.data?.hexEncodedString() ?? ""
        return lhsHex.compare(rhsHex) == .orderedAscending
    }
}

extension ValidatorUpdate {
    init(_ validatorUpdate: Tendermint_Abci_ValidatorUpdate) {
        self.publicKey = PublicKey(validatorUpdate.pubKey)
        self.power = validatorUpdate.power
    }
}

extension Tendermint_Abci_ValidatorUpdate {
    init(_ validatorUpdate: ValidatorUpdate) {
        self.power = validatorUpdate.power
        self.pubKey = Tendermint_Crypto_PublicKey(validatorUpdate.publicKey)
    }
}

extension Data {
    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }

    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        return map { String(format: format, $0) }.joined()
    }
}
