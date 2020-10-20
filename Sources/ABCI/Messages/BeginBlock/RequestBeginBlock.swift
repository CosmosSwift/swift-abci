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

public struct RequestBeginBlock {
    /// The block's hash. This can be derived from the block header.
    public let hash: Data
    /// The block header.
    public let header: Header
    /// Info about the last commit, including the round, and the list of validators a
    /// and which ones signed the last block.
    public let lastCommitInfo: LastCommitInfo
    /// List of evidence of validators that acted maliciously.
    public let byzantineValidators: [Evidence]
}

extension RequestBeginBlock {
    init(_ request: Tendermint_Abci_Types_RequestBeginBlock) {
        self.hash = request.hash
        self.header = Header(request.header)
        self.lastCommitInfo = LastCommitInfo(request.lastCommitInfo)
        self.byzantineValidators = request.byzantineValidators.map(Evidence.init)
    }
}
