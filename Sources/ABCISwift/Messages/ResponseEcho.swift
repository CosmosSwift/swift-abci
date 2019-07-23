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


import Foundation

public class ResponseEcho {
    public let message: String
    
    public init(message: String) {
        self.message = message
    }
}

extension Types_ResponseEcho {
    init(_ r: ResponseEcho) {
        self.message = r.message
    }
}
