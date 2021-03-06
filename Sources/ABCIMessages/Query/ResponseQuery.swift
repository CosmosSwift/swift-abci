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
public struct ResponseQuery<Payload: Codable>: Codable {
    enum CodingKeys: String, CodingKey {
        case code
        case log
        case info
        case index
        case key
        case value
        #warning("For some reasons, the equivalent tendermint resonse query does not use proof_ops but proofOps")
        case proofOps //= "proof_ops"
        case height
        case codespace
    }
    
    /// Response code. Code `0` expresses success, anything else expresses failure.
    public var code: UInt32
    /// The output of the application's logger. May be non-deterministic.
    public var log: String
    /// Additional information. May be non-deterministic.
    public var info: String
    /// The index of the key in the tree.
    @StringBackedInt public var index: Int64
    /// The key of the matching data.
    public var key: Data?
    
    public var value: Payload
    /// Serialized proof for the value data, if requested, to be verified against the `appHash` for the given `height`.
    public var proofOps: ProofOps
    /// The block height from which data was derived. Note that this is the height of the block containing the application's Merkle root hash, which represents
    /// the state as it was after committing the block at `height - 1`.
    @StringBackedInt public var height: Int64
    /// Namespace for the `code`.
    public var codespace: String

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
    ///   - proofOps: Serialized proof for the value data, if requested, to be verified against the `appHash` for the given `height`. This parameter is optional.
    ///   - height: The block height from which data was derived. Note that this is the height of the block containing the application's Merkle root hash, which represents
    ///   the state as it was after committing the block at `height - 1`. Defaults to `0`.
    ///   - codespace: Namespace for the `code`. Defaults to an empty string.
    public init(
        code: UInt32 = 0,
        log: String = "",
        info: String = "",
        index: Int64 = 0,
        key: Data? = nil,
        value: Payload,
        proofOps: ProofOps = ProofOps(),
        height: Int64? = nil,
        codespace: String = ""
    ) {
        self.code = code
        self.log = log
        self.info = info
        self.index = index
        self.key = key
        self.value = value
        self.proofOps = proofOps
        self.height = height ?? 0
        self.codespace = codespace
    }
    
    public func mapPayload<T: Codable>(_ f: (Payload) throws -> T) rethrows -> ResponseQuery<T> {
        ResponseQuery<T>(
            code: code,
            log: log,
            info: info,
            index: index,
            key: key,
            value: try f(value),
            proofOps: proofOps,
            height: height,
            codespace: codespace
        )
    }
}

extension ResponseQuery where Payload == Data {
    public init(
        code: UInt32 = 0,
        log: String = "",
        info: String = "",
        index: Int64 = 0,
        key: Data? = nil,
        value: Data = Data(),
        proofOps: ProofOps = ProofOps(),
        height: Int64 = 0,
        codespace: String = ""
    ) {
        self.code = code
        self.log = log
        self.info = info
        self.index = index
        self.key = key
        self.value = value
        self.proofOps = proofOps
        self.height = height
        self.codespace = codespace
    }
}
