// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  PartSetHeader.swift last updated 02/06/2020
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
