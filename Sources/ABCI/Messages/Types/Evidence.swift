// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  Evidence.swift last updated 02/06/2020
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
import SwiftProtobuf

public struct Evidence {
    public let type: EvidenceType
    public let validator: Validator
    public let height: Int64
    public let time: Date
    public let totalVotingPower: Int64

    public init(
        type: EvidenceType,
        validator: Validator,
         height: Int64,
        time: Date,
        totalVotingPower: Int64
    ) {
        self.type = type
        self.validator = validator
        self.height = height
        self.time = time
        self.totalVotingPower = totalVotingPower
    }
}

extension Evidence {
    init(evidence: Tendermint_Abci_Evidence) {
        self.type = EvidenceType(evidence.type)
        self.validator = Validator(evidence.validator)
        self.height = evidence.height
        self.time = evidence.time.date
        self.totalVotingPower = evidence.totalVotingPower
    }
}

extension Tendermint_Abci_Evidence {
    init(_ evidence: Evidence) {
        self.type = Tendermint_Abci_EvidenceType(evidence.type)
        self.validator = Tendermint_Abci_Validator(evidence.validator)
        self.height = evidence.height
        self.time = Google_Protobuf_Timestamp(date: evidence.time)
        self.totalVotingPower = evidence.totalVotingPower
    }
}
