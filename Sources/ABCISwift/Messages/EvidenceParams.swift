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

public class EvidenceParams {
    public let maxAge: Int64
    
    public init(maxAge: Int64) {
        self.maxAge = maxAge
    }
}

extension Types_EvidenceParams {
    init(_ e: EvidenceParams) {
        self.maxAge = e.maxAge
    }
}
