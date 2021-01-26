// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  PubKey.swift last updated 02/06/2020
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

public struct PubKey1 {
    public let type: String
    public let data: Data

    public init(_ type: String, _ data: Data) {
        self.type = type
        self.data = data
    }
}

extension PubKey1 {
    init(_ pubKey: Tendermint_Abci_Types_PubKey) {
        self.type = pubKey.type
        self.data = pubKey.data
    }
}

extension Tendermint_Abci_Types_PubKey {
    init(_ pubKey: PubKey1) {
        self.type = pubKey.type
        self.data = pubKey.data
    }
}
