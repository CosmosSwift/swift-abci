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
    convenience init(protobuf: Types_ConsensusParams) {
        self.init(BlockParams(maxBytes: protobuf.block.maxBytes, maxGas: protobuf.block.maxGas),
                  EvidenceParams(maxAge: protobuf.evidence.maxAge),
                  ValidatorParams(pubKeyTypes: protobuf.validator.pubKeyTypes))
    }
}

extension Types_ConsensusParams {
    init(_ r: ConsensusParams) {
        self.block = Types_BlockParams(r.block)
        self.evidence = Types_EvidenceParams(r.evidence)
        self.validator = Types_ValidatorParams(r.validator)
    }
}
