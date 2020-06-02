// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  ResponseCommit.swift last updated 02/06/2020
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

public class ResponseCommit: ResponseBase {
    public static func ok(data: Data = Data(), log: String = "") -> ResponseCommit {
        return ResponseCommit(0, data, log)
    }

    public static func error(_ errno: Int, data: Data = Data(), log: String = "") -> ResponseCommit {
        assert(errno > 0)
        return ResponseCommit(UInt32(errno), data, log)
    }
}

extension Types_ResponseCommit {
    init(_ r: ResponseBase) {
        data = r.data
    }
}
