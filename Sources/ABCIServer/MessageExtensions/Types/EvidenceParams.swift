// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  EvidenceParams.swift last updated 02/06/2020
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

extension EvidenceParams {
    init(_ evidenceParams: Tendermint_Types_EvidenceParams) {
        self.init(maxAgeNumBlocks: evidenceParams.maxAgeNumBlocks,
                  maxAgeDuration: evidenceParams.maxAgeDuration.timeInterval)
    }
}
extension Tendermint_Types_EvidenceParams {
    init(_ evidenceParams: EvidenceParams) {
        self.maxAgeNumBlocks = evidenceParams.maxAgeNumBlocks
        self.maxAgeDuration = Google_Protobuf_Duration(evidenceParams.maxAgeDuration)
    }
}
