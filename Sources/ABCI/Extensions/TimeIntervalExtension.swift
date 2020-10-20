// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  TimeIntervalExtension.swift last updated 16/07/2020
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
import SwiftProtobuf

extension TimeInterval {
    public init(_ duration: SwiftProtobuf.Google_Protobuf_Duration) {
        self = Double(duration.seconds) + Double(duration.nanos) / 1_000_000_000
    }
}

extension SwiftProtobuf.Google_Protobuf_Duration {
    public init(_ timeInterval: TimeInterval) {
        let seconds = Int64(timeInterval)
        let nanos = Int32((timeInterval - Double(seconds)) * 1_000_000_000)
        self.init(seconds: seconds, nanos: nanos)
    }
}
