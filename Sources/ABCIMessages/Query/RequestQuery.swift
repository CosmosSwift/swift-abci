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
import DataConvertible

public struct RequestQuery<Payload: DataConvertible> {
    /// when not Data, the typed instance of the Payload`.
    public let payload: Payload
    
    /// Raw query bytes. Can be used with or in lieu of `path`.
    public var data: Data { payload.data }
    /// Path of the request, like an HTTP GET path. Can be used with or in lieu of `data`.
    /// - Apps MUST interpret `/store` as a query by key on the underlying store.
    /// The key SHOULD be specified in the data field.
    /// - Apps SHOULD allow queries over specific types like `/accounts/...` or `/votes/...`.
    public let path: String
    /// The block height for which you want the query, `0` should return data for the latest commited block.
    /// Note that this is the height of the block containing the application's Merkle root hash, which represents
    /// the state as it was after committing the block at `height - 1`.
    public let height: Int64
    /// Return Merkle proof with response, if possible.
    public let prove: Bool

    public init(payload: Payload, path: String, height:Int64, prove: Bool) {
        self.payload = payload
        self.path = path
        self.height = height
        self.prove = prove
    }
}
