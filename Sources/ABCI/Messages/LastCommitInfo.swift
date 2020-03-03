//===----------------------------------------------------------------------===//
//
// This source file is part of the CosmsosSwift/ABCI open source project
//
// Copyright (c) 2019 CosmsosSwift/ABCI project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of CosmsosSwift/ABCI project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

public class LastCommitInfo {
    public let round: Int32
    public let votes: [VoteInfo]
    
    public init(_ round: Int32, _ votes: [VoteInfo]) {
        self.round = round
        self.votes = votes
    }
}

extension LastCommitInfo {
    convenience init(protobuf: Types_LastCommitInfo) {
        self.init(protobuf.round, protobuf.votes.map{ VoteInfo(protobuf: $0) })
    }
}

extension Types_LastCommitInfo {
    init(_ l: LastCommitInfo) {
        self.round = l.round
        self.votes = l.votes.map{ Types_VoteInfo($0) }
    }
}
