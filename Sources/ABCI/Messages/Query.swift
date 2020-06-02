// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  Query.swift last updated 02/06/2020
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
