// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  VoteInfo.swift last updated 02/06/2020
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

extension VoteInfo {
    init(voteInfo: Tendermint_Abci_VoteInfo) {
        self.init(validator: Validator(voteInfo.validator),
                  signedLastBlock: voteInfo.signedLastBlock)
    }
}

extension Tendermint_Abci_VoteInfo {
    init(_ voteInfo: VoteInfo) {
        self.validator = Tendermint_Abci_Validator(voteInfo.validator)
        self.signedLastBlock = voteInfo.signedLastBlock
    }
}
