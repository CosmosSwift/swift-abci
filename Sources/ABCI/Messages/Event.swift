//===----------------------------------------------------------------------===//
//
// This source file is part of the ABCCosmsosSwift/ABCIISwift open source project
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

public class Event {
    public let type: String
    public let attributes: [Data: Data]
    
    public init(_ type: String, _ attributes: [Data: Data]) {
        self.type = type
        self.attributes = attributes
    }
}

extension Types_Event {
    init(_ e: Event) {
        self.type = e.type
        self.attributes = e.attributes.map({ (arg: (key: Data, value: Data)) -> Common_KVPair in
            let (k, v) = arg
            return Common_KVPair(key: k, value: v)
        })
    }
}

