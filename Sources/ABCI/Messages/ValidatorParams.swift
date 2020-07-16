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

public class ValidatorParams {
    public let pubKeyTypes: [String]

    public init(pubKeyTypes: [String]) {
        self.pubKeyTypes = pubKeyTypes
    }
}

extension Tendermint_Abci_Types_ValidatorParams {
    init(_ v: ValidatorParams) {
        pubKeyTypes = v.pubKeyTypes
    }
}
