//===----------------------------------------------------------------------===//
//
// This source file is part of the CosmsosSwift/ABCI open source project
//
// Copyright (c) 2019 CosmsosSwift/ABCI project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of CosmsosSwift/ABCI project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

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
        assert( errno > 0)
        return ResponseDeliverTx(UInt32(errno), data, log, gasWanted, gasUsed, events, codespace)
    }
}

extension Types_ResponseDeliverTx {
    init(_ r: ResponseDeliverTx) {
        // TODO: properly init
        self.code = r.code
        self.data = r.data
        self.log = r.log
    }
}

