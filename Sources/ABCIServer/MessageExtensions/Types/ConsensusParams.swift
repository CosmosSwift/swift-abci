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
import ABCIMessages

extension ConsensusParams {
   init(_ consensusParams: Tendermint_Abci_ConsensusParams) {
    self.init(block: BlockParams(consensusParams.block),
              evidence: EvidenceParams(consensusParams.evidence),
              validator: ValidatorParams(consensusParams.validator))
    }
}

extension Tendermint_Abci_ConsensusParams {
    init(_ consensusParams: ConsensusParams) {
        self.block = Tendermint_Abci_BlockParams(consensusParams.block)
        self.evidence = Tendermint_Types_EvidenceParams(consensusParams.evidence)
        self.validator = Tendermint_Types_ValidatorParams(consensusParams.validator)
    }
}
