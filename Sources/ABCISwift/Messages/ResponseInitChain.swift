//===----------------------------------------------------------------------===//
//
// This source file is part of the ABCISwift open source project
//
// Copyright (c) 2019 ABCISwift project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of ABCISwift project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

public class ResponseInitChain {
    public let consensusParams: ConsensusParams
    public let validators: [ValidatorUpdate]
    
    public init(_ consensusParams: ConsensusParams, _ validators: [ValidatorUpdate]) {
        self.consensusParams = consensusParams
        self.validators = validators
    }
}

extension Types_ResponseInitChain {
    init(_ r: ResponseInitChain) {
        self.consensusParams = Types_ConsensusParams(r.consensusParams)
        self.validators = r.validators.map{ Types_ValidatorUpdate($0) }
    }
}
