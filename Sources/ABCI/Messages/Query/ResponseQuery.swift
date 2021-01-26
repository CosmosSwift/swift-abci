// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  ResponseQuery.swift last updated 16/07/2020
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

/// Queries data from the application at current or past height.
///
/// A Merkle proof may be returned with a self-describing `type` property to support many types of Merkle trees and encoding formats.
public struct ResponseQuery {
    /// Response code. Code `0` expresses success, anything else expresses failure.
    public let code: UInt32
    /// The output of the application's logger. May be non-deterministic.
    public let log: String
    /// Additional information. May be non-deterministic.
    public let info: String
    /// The index of the key in the tree.
    public let index: Int64
    /// The key of the matching data.
    public var key: Data
    /// The value of the matching data.
    public let value: Data
    /// Serialized proof for the value data, if requested, to be verified against the `appHash` for the given `height`.
    public let proof: Proof
    /// The block height from which data was derived. Note that this is the height of the block containing the application's Merkle root hash, which represents
    /// the state as it was after committing the block at `height - 1`.
    public var height: Int64
    /// Namespace for the `code`.
    public let codespace: String
    
    /// Queries data from the application at current or past height.
    ///
    /// A Merkle proof may be returned with a self-describing `type` property to support many types of Merkle trees and encoding formats.
    /// - Parameters:
    ///   - code: Response code. Code `0` expresses success, anything else expresses failure. Defaults to `0`.
    ///   - log: The output of the application's logger. May be non-deterministic. Defaults to an empty string.
    ///   - info: Additional information. May be non-deterministic. Defaults to an empty string.
    ///   - index: The index of the key in the tree. Defaults to `0`.
    ///   - key: The key of the matching data. Defaults to an empty `Data` value.
    ///   - value: The value of the matching data. Defaults to an empty `Data` value.
    ///   - proof: Serialized proof for the value data, if requested, to be verified against the `appHash` for the given `height`. This parameter is optional.
    ///   - height: The block height from which data was derived. Note that this is the height of the block containing the application's Merkle root hash, which represents
    ///   the state as it was after committing the block at `height - 1`. Defaults to `0`.
    ///   - codespace: Namespace for the `code`. Defaults to an empty string.
    public init(
        code: UInt32 = 0,
        log: String = "",
        info: String = "",
        index: Int64 = 0,
        key: Data = Data(),
        value: Data = Data(),
        proof: Proof = Proof(),
        height: Int64 = 0,
        codespace: String = ""
    ) {
        self.code = code
        self.log = log
        self.info = info
        self.index = index
        self.key = key
        self.value = value
        self.proof = proof
        self.height = height
        self.codespace = codespace
    }
}

extension Tendermint_Abci_Types_ResponseQuery {
    init(_ response: ResponseQuery) {
        self.code = response.code
        self.key = response.key
        self.value = response.value
        self.proof = Tendermint_Crypto_Merkle_Proof(response.proof)
        self.index = response.index
        self.height = response.height
        self.codespace = response.codespace
        self.log = response.log
    }
}
