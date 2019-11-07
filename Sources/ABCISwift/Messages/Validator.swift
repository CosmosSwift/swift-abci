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

public class Validator {
    public let address: Data
    public let power: Int64
    
    public init(_ address: Data, _ power: Int64) {
        self.address = address
        self.power = power
    }
}

extension Validator {
    convenience init(protobuf: Types_Validator) {
        self.init(protobuf.address, protobuf.power)
    }
}

extension Types_Validator {
    init(_ r: Validator) {
        self.power = r.power
        self.address = r.address
    }
}
