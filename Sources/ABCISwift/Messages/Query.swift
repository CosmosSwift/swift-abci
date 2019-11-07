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

public class Query {
    public let data: Data
    public let path: String
    public let height: Int64
    public let prove: Bool
    
    public init(_ data: Data, _ path: String, _ height: Int64, _ prove: Bool) {
        self.data = data
        self.path = path
        self.height = height
        self.prove = prove
    }
}
