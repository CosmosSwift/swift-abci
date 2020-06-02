// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  ResponseDeliverTx.swift last updated 02/06/2020
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

public class ResponseDeliverTx: ResponseBase {
    public let gasWanted: Int64
    public let gasUsed: Int64
    public let events: [Event]
    public let codespace: String

    private init(_ code: UInt32, _ data: Data, _ log: String, _ gasWanted: Int64, _ gasUsed: Int64, _ events: [Event], _ codespace: String) {
        self.gasWanted = gasWanted
        self.gasUsed = gasUsed
        self.events = events
        self.codespace = codespace
        super.init(code, data, log)
    }

    public static func ok(gasWanted: Int64 = 0, gasUsed: Int64 = 0, events: [Event] = [], codespace: String = "", data: Data = Data(), log: String = "") -> ResponseDeliverTx {
        return ResponseDeliverTx(0, data, log, gasWanted, gasUsed, events, codespace)
    }

    public static func error(_ errno: Int, gasWanted: Int64 = 0, gasUsed: Int64 = 0, events: [Event] = [], codespace: String = "", data: Data = Data(), log: String = "") -> ResponseDeliverTx {
        assert(errno > 0)
        return ResponseDeliverTx(UInt32(errno), data, log, gasWanted, gasUsed, events, codespace)
    }
}

extension Types_ResponseDeliverTx {
    init(_ r: ResponseDeliverTx) {
        // TODO: properly init
        code = r.code
        data = r.data
        log = r.log
    }
}
