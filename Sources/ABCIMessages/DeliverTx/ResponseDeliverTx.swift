// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  ResponseCheckTx.swift last updated 16/07/2020
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

/// Executes transactions in full.
///
/// Transactions where `ResponseCheckTx.code` is not zero will be rejected.
public struct ResponseDeliverTx: Codable {
    enum CodingKeys: String, CodingKey {
        case code
        case data
        case log
        case info
        case gasWanted = "gas_wanted"
        case gasUsed = "gas_used"
        case events
        case codespace
    }
    
    /// Response code. Code `0` expresses success, anything else expresses failure.
    public let code: UInt32
    /// Result bytes, if any.
    public let data: Data
    /// The output of the application's logger. May be non-deterministic.
    public let log: String
    /// Additional information. May be non-deterministic.
    public let info: String
    /// Amount of gas required for the transaction.
    public let gasWanted: Int64
    /// Amount of gas consumed by the transaction.
    public let gasUsed: Int64
    /// Type and Key-Value events for indexing transactions (eg. by account).
    public let events: [Event]
    /// Namespace for the `code`.
    public let codespace: String

    /// Executes transactions in full.
    ///
    /// Transactions where `ResponseCheckTx.code` is not zero will be rejected.
    /// - Parameters:
    ///   - code: Response code. Code `0` expresses success, anything else expresses failure. Defaults to `0`.
    ///   - data: Result bytes, if any. Defaults to an empty `Data` value.
    ///   - log: The output of the application's logger. May be non-deterministic. Defaults to an empty string.
    ///   - info: Additional information. May be non-deterministic. Defaults to an empty string.
    ///   - gasWanted: Amount of gas required for the transaction. Defaults to `0`.
    ///   - gasUsed: Amount of gas consumed by the transaction. Defaults to `0`.
    ///   - events: Type and Key-Value events for indexing transactions (eg. by account). Defaults to an empty array.
    ///   - codespace: Namespace for the `code`. Defaults to an empty string.
    public init(
        code: UInt32 = 0,
        data: Data = Data(),
        log: String = "",
        info: String = "",
        gasWanted: Int64 = 0,
        gasUsed: Int64 = 0,
        events: [Event] = [],
        codespace: String = ""
    ) {
        self.code = code
        self.data = data
        self.log = log
        self.info = info
        self.gasWanted = gasWanted
        self.gasUsed = gasUsed
        self.events = events
        self.codespace = codespace
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decode(UInt32.self, forKey: .code)
        self.data = (try? container.decode(Data.self, forKey: .data)) ?? Data()
        self.log = try container.decode(String.self, forKey: .log)
        self.info = try container.decode(String.self, forKey: .info)
        self.gasWanted = try container.decode(Int64.self, forKey: .gasWanted)
        self.gasUsed = try container.decode(Int64.self, forKey: .gasUsed)
        self.events = try container.decode([Event].self, forKey: .events)
        self.codespace = try container.decode(String.self, forKey: .codespace)
    }
    
    
}
