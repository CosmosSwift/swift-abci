// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  Event.swift last updated 02/06/2020
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

public struct Event: Codable {
    public let type: String
    public let attributes: [Data: Data]

    public init(type: String, attributes: [Data: Data]) {
        self.type = type
        self.attributes = attributes
    }
}

extension Tendermint_Abci_Types_Event {
    init(_ event: Event) {
        self.type = event.type
        
        self.attributes = event.attributes.map { pair in
            Tendermint_Libs_Kv_Pair(key: pair.key, value: pair.value)
        }
    }
}
