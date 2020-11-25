// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  ValidatorParams.swift last updated 02/06/2020
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

public struct ValidatorParams {
    public let pubKeyTypes: [String]

    public init(pubKeyTypes: [String] = ["ed25519"]) {
        self.pubKeyTypes = pubKeyTypes
    }
}

extension ValidatorParams {
    init(_ validatorParams: Tendermint_Types_ValidatorParams) {
        self.pubKeyTypes = validatorParams.pubKeyTypes
    }
}

extension Tendermint_Types_ValidatorParams {
    init(_ validatorParams: ValidatorParams) {
        self.pubKeyTypes = validatorParams.pubKeyTypes
    }
}
