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

import Foundation
import SwiftProtobuf

public struct EvidenceParams: Codable {
    public let maxAgeNumBlocks: Int64
    public let maxAgeDuration: TimeInterval

    public init(
        maxAgeNumBlocks: Int64 = 100_000,
        maxAgeDuration: TimeInterval = 172_800 // 48h
    ) {
        self.maxAgeNumBlocks = maxAgeNumBlocks
        self.maxAgeDuration = maxAgeDuration
    }
}

extension EvidenceParams {
    init(_ evidenceParams: Tendermint_Abci_Types_EvidenceParams) {
        self.maxAgeNumBlocks = evidenceParams.maxAgeNumBlocks
        self.maxAgeDuration = evidenceParams.maxAgeDuration.timeInterval
    }
}
extension Tendermint_Abci_Types_EvidenceParams {
    init(_ evidenceParams: EvidenceParams) {
        self.maxAgeNumBlocks = evidenceParams.maxAgeNumBlocks
        self.maxAgeDuration = Google_Protobuf_Duration(evidenceParams.maxAgeDuration)
    }
}
