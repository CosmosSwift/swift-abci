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

/// Returns information about the application state.
///
/// Used to sync Tendermint with the application during a handshake that happens on startup.
/// A stateful application should alway return `lastBlockHash` and `lastBlockHeight` to prevent Tendermint
/// from replaying from the beginning. If `lastBlockHeight` == 0, Tendermint will call `initChain`.
///
/// NOTICE:
/// - Called when the app first starts.
/// - The returned `appVersion` will be included in the `Header` of every block.
/// - Tendermint expects `lastBlockAppHash` and `lastBlockHeight` to be updated during `Commit`,
/// ensuring that `Commit` is never called twice for the same block height.
public struct ResponseInfo {
    public let data: String
    public let version: String
    public let appVersion: UInt64
    public let lastBlockHeight: Int64
    public let lastBlockAppHash: Data
    
    /// Returns information about the application state.
    ///
    /// Used to sync Tendermint with the application during a handshake that happens on startup.
    /// A stateful application should alway return `lastBlockHash` and `lastBlockHeight` to prevent Tendermint
    /// from replaying from the beginning. If `lastBlockHeight` == 0, Tendermint will call `initChain`.
    ///
    /// NOTICE:
    /// - Called when the app first starts.
    /// - The returned `appVersion` will be included in the `Header` of every block.
    /// - Tendermint expects `lastBlockAppHash` and `lastBlockHeight` to be updated during `Commit`,
    /// ensuring that `Commit` is never called twice for the same block height.
    /// - Parameters:
    ///   - data: Some arbitrary information. Defaults to an empty string.
    ///   - version: The application software semantic version. Defaults to an empty string.
    ///   - appVersion: The application protocol version. Defaults to `0`.
    ///   - lastBlockHeight: Latest block for which the app has called Commit. Defaults to `0`.
    ///   - lastBlockAppHash: Latest result of Commit. Defaults to an empty `Data` value.
    public init(
        data: String = "",
        version: String = "",
        appVersion: UInt64 = 0,
        lastBlockHeight: Int64 = 0,
        lastBlockAppHash: Data = Data()
    ) {
        self.data = data
        self.version = version
        self.appVersion = appVersion
        self.lastBlockHeight = lastBlockHeight
        self.lastBlockAppHash = lastBlockAppHash
    }
}

extension Tendermint_Abci_Types_ResponseInfo {
    init(_ tendermintResponse: ResponseInfo) {
        self.data = tendermintResponse.data
        self.version = tendermintResponse.version
        self.appVersion = tendermintResponse.appVersion
        self.lastBlockHeight = tendermintResponse.lastBlockHeight
        self.lastBlockAppHash = tendermintResponse.lastBlockAppHash
    }
}
