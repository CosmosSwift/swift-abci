// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  EvidenceParams.swift last updated 02/06/2020
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

public class EvidenceParams {
    public let maxAge: Int64

    public init(maxAge: Int64) {
        self.maxAge = maxAge
    }
}

extension Types_EvidenceParams {
    init(_ e: EvidenceParams) {
        maxAge = e.maxAge
    }
}
