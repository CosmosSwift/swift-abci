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

public class PartSetHeader {
    public let total: Int32
    public let hash: Data
    
    public init(_ total: Int32, _ hash: Data) {
        self.total = total
        self.hash = hash
    }
}

extension PartSetHeader {
    convenience init(protobuf: Types_PartSetHeader) {
        self.init(protobuf.total, protobuf.hash)
    }
}
