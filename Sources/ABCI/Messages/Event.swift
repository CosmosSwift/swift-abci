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

public class Event {
    public let type: String
    public let attributes: [Data: Data]

    public init(_ type: String, _ attributes: [Data: Data]) {
        self.type = type
        self.attributes = attributes
    }
}

extension Types_Event {
    init(_ e: Event) {
        type = e.type
        attributes = e.attributes.map { (arg: (key: Data, value: Data)) -> Common_KVPair in
            let (k, v) = arg
            return Common_KVPair(key: k, value: v)
        }
    }
}
