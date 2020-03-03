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

public class ResponseEndBlock {
    public let updates: [ValidatorUpdate]
    public let consensusUpdates: ConsensusParams
    public let events: [Event]
    
    public init(updates: [ValidatorUpdate], consensusUpdates: ConsensusParams, events: [Event]) {
        self.updates = updates
        self.consensusUpdates = consensusUpdates
        self.events = events
    }
}

extension Types_ResponseEndBlock {
    init(_ r: ResponseEndBlock) {
        self.validatorUpdates = r.updates.map{Types_ValidatorUpdate($0)}
        self.consensusParamUpdates = Types_ConsensusParams(r.consensusUpdates)
        self.events = r.events.map{ Types_Event($0) }
    }
}
