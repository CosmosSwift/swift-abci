// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  ResponseCheckTx.swift last updated 16/07/2020
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

extension Tendermint_Abci_ResponseCheckTx {
    init(_ response: ResponseCheckTx) {
        self.code = response.code
        self.data = response.data
        self.log = response.log
        self.info = response.info
        self.gasWanted = response.gasWanted
        self.gasUsed = response.gasUsed
        self.events = response.events.map(Tendermint_Abci_Event.init)
        self.codespace = response.codespace
    }
}
