// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  ResponseBase.swift last updated 02/06/2020
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

public class ResponseBase {
    let code: UInt32
    let data: Data
    let log: String

    init(_ code: UInt32, _ data: Data, _ log: String) {
        self.code = code
        self.data = data
        self.log = log
    }
}

extension ResponseBase: CustomStringConvertible {
    public var description: String {
        return "ABCI[code:\(code), data:\(data), log:\(log)]"
    }
}
