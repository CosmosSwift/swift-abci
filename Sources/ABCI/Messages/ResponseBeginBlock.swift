// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  ResponseBeginBlock.swift last updated 02/06/2020
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

public class ResponseBeginBlock {
    public let events: [Event]

    public init(_ events: [Event]) {
        self.events = events
    }
}

extension Types_ResponseBeginBlock {
    init(_ r: ResponseBeginBlock) {
        events = r.events.map { Types_Event($0) }
    }
}
