// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  RequestApplySnapshotChunk.swift last updated 16/07/2020
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

extension RequestApplySnapshotChunk {
    init(_ request: Tendermint_Abci_RequestApplySnapshotChunk) {
        self.init(index: request.index,
                  chunk: request.chunk,
                  sender: request.sender)
    }
}
