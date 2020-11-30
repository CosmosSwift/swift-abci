// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  Query.swift last updated 02/06/2020
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

public struct RequestCheckTx {
    /// The request transaction bytes.
    public let tx: Data
    /// The type of `CheckTx` request. At present there are two possible values.
    /// `new`, used when a full check is required and `recheck`, wheh the mempool
    /// is initiating a normal recheck of a transaction.
    public let type: CheckTxType
}

extension RequestCheckTx {
    init(_ request: Tendermint_Abci_RequestCheckTx) {
        self.tx = request.tx
        self.type = CheckTxType(request.type)
    }
}
