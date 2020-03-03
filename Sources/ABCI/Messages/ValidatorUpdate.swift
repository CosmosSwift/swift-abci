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

public class ValidatorUpdate {
    public let pubKey: PubKey
    public let power: Int64
    
    public init(_ pubKey: PubKey, _ power: Int64) {
        self.pubKey = pubKey
        self.power = power
    }
}

extension ValidatorUpdate {
    convenience init(protobuf: Types_ValidatorUpdate) {
        self.init(PubKey(protobuf.pubKey.type, protobuf.pubKey.data), protobuf.power)
    }
}

extension Types_ValidatorUpdate {
    init(_ r: ValidatorUpdate) {
        self.power = r.power
        self.pubKey = Types_PubKey(r.pubKey)
    }
}
