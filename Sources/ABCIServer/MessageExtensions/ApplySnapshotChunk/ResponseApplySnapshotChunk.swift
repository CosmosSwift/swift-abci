// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  ResponseApplySnapshotChunk.swift last updated 16/07/2020
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


extension Tendermint_Abci_ResponseApplySnapshotChunk {
    init(_ response: ResponseApplySnapshotChunk) {
        switch response.result {
        case .unknown:
            self.result = .unknown
        case .accept:
            self.result = .accept
        case .abort:
            self.result = .abort
        case .retry:
            self.result = .retry
        case .retrySnapshot:
            self.result = .retrySnapshot
        case .rejectSnapshot:
            self.result = .rejectSnapshot
        }
        
        self.refetchChunks = response.refetchChunks
        self.rejectSenders = response.rejectSenders
    }
}
