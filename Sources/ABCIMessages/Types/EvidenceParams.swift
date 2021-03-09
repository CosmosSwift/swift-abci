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

import Foundation

public struct EvidenceParams: Codable {
    public let maxAgeNumBlocks: Int64
    public let maxAgeDuration: TimeInterval

    public init(
        maxAgeNumBlocks: Int64 = 100_000,
        maxAgeDuration: TimeInterval = 172_800 // 48h
    ) {
        self.maxAgeNumBlocks = maxAgeNumBlocks
        self.maxAgeDuration = maxAgeDuration
    }
}
