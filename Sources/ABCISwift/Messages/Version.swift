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

public class Version {
    public let block : UInt64
    public let app: UInt64
    
    
    public init(_ block: UInt64, _ app: UInt64) {
        self.block = block
        self.app = app
    }
}

extension Types_Version {
    init(_ v: Version) {
        self.block  = v.block
        self.app = v.app
    }
}
