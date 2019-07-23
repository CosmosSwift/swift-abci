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


import Foundation

public class PubKey {
    public let type: String
    public let data: Data
    
    public init(_ type: String, _ data: Data) {
        self.type = type
        self.data = data
    }
}

extension Types_PubKey {
    init(_ p: PubKey) {
        self.type = p.type
        self.data = p.data
    }
}
