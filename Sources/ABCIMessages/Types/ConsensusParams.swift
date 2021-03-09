// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  ConsensusParams.swift last updated 16/07/2020
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

public struct ConsensusParams: Codable {
    public let block: BlockParams
    public let evidence: EvidenceParams
    public let validator: ValidatorParams

    public init(
        block: BlockParams = BlockParams(),
        evidence: EvidenceParams = EvidenceParams(),
        validator: ValidatorParams = ValidatorParams()
    ) {
        self.block = block
        self.evidence = evidence
        self.validator = validator
    }
}
