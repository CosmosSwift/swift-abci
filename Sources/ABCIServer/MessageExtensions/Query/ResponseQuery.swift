// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  ResponseQuery.swift last updated 16/07/2020
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
import ABCIMessages

extension Tendermint_Abci_ResponseQuery {
    init(_ response: ResponseQuery<Data>) {
        self.code = response.code
        self.key = response.key
        self.value = response.value
        self.proofOps = Tendermint_Crypto_ProofOps(response.proofOps)
        self.index = Int64(response.index)
        self.height = Int64(response.height)
        self.codespace = response.codespace
        self.log = response.log
    }
}
