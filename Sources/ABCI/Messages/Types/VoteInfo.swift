// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  VoteInfo.swift last updated 02/06/2020
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

public class VoteInfo {
    public let validator: Validator
    public let signedLastBlock: Bool

    public init(_ validator: Validator, _ signedLastBlock: Bool) {
        self.validator = validator
        self.signedLastBlock = signedLastBlock
    }
}

extension VoteInfo {
    convenience init(protobuf: Tendermint_Abci_VoteInfo) {
        self.init(Validator(protobuf: protobuf.validator), protobuf.signedLastBlock)
    }
}

extension Tendermint_Abci_VoteInfo {
    init(_ v: VoteInfo) {
        validator = Tendermint_Abci_Validator(v.validator)
        signedLastBlock = v.signedLastBlock
    }
}
