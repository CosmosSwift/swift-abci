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

public class ResponseBase {
    let code: UInt32
    let data: Data
    let log: String
    
    init(_ code: UInt32, _ data: Data, _ log: String) {
        self.code = code
        self.data = data
        self.log = log
    }
}

extension ResponseBase: CustomStringConvertible {
    public var description: String {
        get {
            return "ABCI[code:\(code), data:\(data), log:\(log)]"
        }
    }
}
