// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  BlockParams.swift last updated 02/06/2020
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

extension BlockParams {
    init(_ blockParams: Tendermint_Abci_BlockParams) {
        self.init(maxBytes: blockParams.maxBytes,
                  maxGas: blockParams.maxGas)
    }
}

extension Tendermint_Abci_BlockParams {
    init(_ blockParams: BlockParams) {
        self.maxBytes = blockParams.maxBytes
        self.maxGas = blockParams.maxGas
    }
}
