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

import Foundation

public class ProofOp {
    public let type: String
    public let key: Data
    public let data: Data
    
    public init(type: String, key: Data , data: Data) {
        self.type = type
        self.key = key
        self.data = data
    }
}

extension Merkle_ProofOp{
    init(_ p: ProofOp) {
        self.type = p.type
        self.key = p.key
        self.data = p.data
    }
}
