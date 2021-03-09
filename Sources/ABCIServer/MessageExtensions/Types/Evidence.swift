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
import ABCIMessages
import SwiftProtobuf




extension Evidence {
    init(evidence: Tendermint_Abci_Evidence) {
        self.init(type: EvidenceType(evidence.type),
                  validator: Validator(evidence.validator),
                  height: evidence.height,
                  time: evidence.time.date,
                  totalVotingPower: evidence.totalVotingPower)
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
