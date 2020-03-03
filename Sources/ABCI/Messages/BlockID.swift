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

public class BlockID {
    public let hash: Data
    public let parts: PartSetHeader
    
    public init(_ hash: Data, _ parts: PartSetHeader) {
        self.hash = hash
        self.parts = parts
    }

}

extension BlockID {
    convenience init (protobuf: Types_BlockID) {
        self.init(protobuf.hash, PartSetHeader(protobuf: protobuf.partsHeader))
    }
}
