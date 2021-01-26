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

extension ConsensusParams {
   init(_ consensusParams: Tendermint_Abci_Types_ConsensusParams) {
        self.block = BlockParams(consensusParams.block)
        self.evidence = EvidenceParams(consensusParams.evidence)
        self.validator = ValidatorParams(consensusParams.validator)
    }
}

extension Tendermint_Abci_Types_ConsensusParams {
    init(_ consensusParams: ConsensusParams) {
        self.block = Tendermint_Abci_Types_BlockParams(consensusParams.block)
        self.evidence = Tendermint_Abci_Types_EvidenceParams(consensusParams.evidence)
        self.validator = Tendermint_Abci_Types_ValidatorParams(consensusParams.validator)
    }
}
