//===----------------------------------------------------------------------===//
//
// This source file is part of the ABCISwift open source project
//
// Copyright (c) 2019 ABCISwift project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of ABCISwift project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

public class ResponseBeginBlock {
    public let events: [Event]
    
    public init(_ events: [Event]) {
        self.events = events
    }
}

extension Types_ResponseBeginBlock {
    init(_ r: ResponseBeginBlock) {
        self.events = r.events.map{ Types_Event($0) }
    }
}
