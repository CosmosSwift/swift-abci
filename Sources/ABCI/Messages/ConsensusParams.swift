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

public class ConsensusParams {
    public let block: BlockParams
    public let evidence: EvidenceParams
    public let validator: ValidatorParams

    public init(_ block: BlockParams, _ evidence: EvidenceParams, _ validator: ValidatorParams) {
        self.block = block
        self.evidence = evidence
        self.validator = validator
    }
}

extension ConsensusParams {
    convenience init(protobuf: Tendermint_Abci_Types_ConsensusParams) {
        self.init(BlockParams(maxBytes: protobuf.block.maxBytes, maxGas: protobuf.block.maxGas),
                  EvidenceParams(maxAgeNumBlocks: protobuf.evidence.maxAgeNumBlocks, maxAgeDuration: TimeInterval(protobuf: protobuf.evidence.maxAgeDuration)),
                  ValidatorParams(pubKeyTypes: protobuf.validator.pubKeyTypes))
    }
}

extension Tendermint_Abci_Types_ConsensusParams {
    init(_ r: ConsensusParams) {
        block = Tendermint_Abci_Types_BlockParams(r.block)
        evidence = Tendermint_Abci_Types_EvidenceParams(r.evidence)
        validator = Tendermint_Abci_Types_ValidatorParams(r.validator)
    }
}
