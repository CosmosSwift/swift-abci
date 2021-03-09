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

public struct RequestInfo {
    /// The Tendermint software semantic version.
    public let version: String
    /// The Tendermint Block Protocol version.
    public let blockVersion: UInt64
    /// The Tendermint P2P Protocol version
    public let p2pVersion: UInt64
    
    public init(version: String, blockVersion: UInt64, p2pVersion: UInt64) {
        self.version = version
        self.blockVersion = blockVersion
        self.p2pVersion = p2pVersion
    }
}
