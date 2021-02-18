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

public struct RequestDeliverTx<Payload> {
    public let payload: Payload
    
    public init(payload: Payload) {
        self.payload = payload
    }
}

extension RequestDeliverTx where Payload == Data {
    /// The request transaction bytes.
    public var tx: Data { payload }
    
    public init(tx: Data) {
        self.init(payload: tx)
    }
}
