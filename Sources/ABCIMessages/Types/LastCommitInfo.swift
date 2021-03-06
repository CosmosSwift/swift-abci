// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  LastCommitInfo.swift last updated 16/07/2020
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

public struct LastCommitInfo {
    public let round: Int32
    public let votes: [VoteInfo]

    public init(round: Int32, votes: [VoteInfo]) {
        self.round = round
        self.votes = votes
    }
}
