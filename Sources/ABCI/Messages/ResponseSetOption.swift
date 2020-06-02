// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  ResponseSetOption.swift last updated 02/06/2020
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

public class ResponseSetOption {
    //    public let code: UInt32
    public let log: String
    //    public let info: String

    public init( /* _ code: UInt32 = 0, */ _ log: String = "" /* , _ info: String = "" */ ) {
        //        self.code = code
        self.log = log
        //        self.info = info
    }
}

extension Types_ResponseSetOption {
    init(_ r: ResponseSetOption) {
        //        self.code = r.code
        log = r.log
        //        self.info = r.info
    }
}
