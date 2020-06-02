// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  Validator.swift last updated 02/06/2020
//
//  Copyright © 2020 Katalysis B.V. and the CosmosSwift project authors.
//  Licensed under Apache License v2.0
//
//  See LICENSE.txt for license information
//  See CONTRIBUTORS.txt for the list of CosmosSwift project authors
//
//  SPDX-License-Identifier: Apache-2.0
//
// ===----------------------------------------------------------------------===

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
        power = r.power
        address = r.address
    }
}