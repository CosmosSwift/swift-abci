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

public class BlockParams {
    public let maxBytes: Int64
    public let maxGas: Int64
    
    public init(maxBytes: Int64, maxGas: Int64) {
        self.maxBytes = maxBytes
        self.maxGas = maxGas
    }
}

extension Types_BlockParams {
    init(_ b: BlockParams) {
        self.maxBytes = b.maxBytes
        self.maxGas = b.maxGas
    }
}
