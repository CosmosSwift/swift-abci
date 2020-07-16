// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  ResponseInfo.swift last updated 16/07/2020
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

extension Tendermint_Abci_Types_ResponseInfo {
    init(_ r: ResponseInfo) {
        data = r.data
        version = r.version
        appVersion = r.appVersion
        lastBlockHeight = r.lastBlockHeight
        lastBlockAppHash = r.lastBlockAppHash
    }
}
