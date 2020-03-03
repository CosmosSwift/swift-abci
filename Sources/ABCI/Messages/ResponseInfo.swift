//===----------------------------------------------------------------------===//
//
// This source file is part of the CosmsosSwift/ABCI open source project
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

public class ResponseInfo {
    public let data: String
    public let version: String
    public let appVersion: UInt64
    public let lastBlockHeight: Int64
    public let lastBlockAppHash: Data
    
    public init(_ data: String = "", _ version: String = "", _ appVersion: UInt64 = 0, _ lastBlockHeight: Int64 = 0, _ lastBlockAppHash: Data = Data()) {
        self.data = data
        self.version = version
        self.appVersion = appVersion
        self.lastBlockHeight = lastBlockHeight
        self.lastBlockAppHash = lastBlockAppHash
    }
}

extension Types_ResponseInfo {
    init(_ r: ResponseInfo) {
        self.data = r.data
        self.version = r.version
        self.appVersion = r.appVersion
        self.lastBlockHeight = r.lastBlockHeight
        self.lastBlockAppHash = r.lastBlockAppHash
    }
}
