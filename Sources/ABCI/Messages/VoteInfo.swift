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

public class VoteInfo {
    public let validator: Validator
    public let signedLastBlock: Bool
    
    public init(_ validator: Validator, _ signedLastBlock: Bool) {
        self.validator = validator
        self.signedLastBlock = signedLastBlock
    }
}

extension VoteInfo {
    convenience init(protobuf: Types_VoteInfo) {
        self.init(Validator(protobuf: protobuf.validator), protobuf.signedLastBlock)
    }
}

extension Types_VoteInfo {
    init(_ v: VoteInfo) {
        self.validator = Types_Validator(v.validator)
        self.signedLastBlock = v.signedLastBlock
    }
}
