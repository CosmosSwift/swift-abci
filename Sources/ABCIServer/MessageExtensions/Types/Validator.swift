// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  Validator.swift last updated 02/06/2020
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

extension Validator {
    init(_ validator: Tendermint_Abci_Validator) {
        self.init(address: validator.address,
                  power: validator.power)
    }
}

extension Tendermint_Abci_Validator {
    init(_ validator: Validator) {
        self.power = validator.power
        self.address = validator.address
    }
}
