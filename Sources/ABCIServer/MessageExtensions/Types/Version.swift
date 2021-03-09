// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  Version.swift last updated 02/06/2020
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
import ABCIMessages

extension Version {
    init(_ version: Tendermint_Version_Consensus) {
        self.init(block: version.block,
        app: version.app)
    }
}

extension Tendermint_Version_Consensus {
    init(_ version: Version) {
        self.block = version.block
        self.app = version.app
    }
}
