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

public class Version {
    public let block: UInt64
    public let app: UInt64

    public init(_ block: UInt64, _ app: UInt64) {
        self.block = block
        self.app = app
    }
}

extension Tendermint_Abci_Types_Version {
    init(_ v: Version) {
        block = v.block
        app = v.app
    }
}
