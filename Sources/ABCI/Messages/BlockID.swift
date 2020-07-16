// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  BlockID.swift last updated 02/06/2020
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

public class BlockID {
    public let hash: Data
    public let parts: PartSetHeader

    public init(_ hash: Data, _ parts: PartSetHeader) {
        self.hash = hash
        self.parts = parts
    }
}

extension BlockID {
    convenience init(protobuf: Tendermint_Abci_Types_BlockID) {
        self.init(protobuf.hash, PartSetHeader(protobuf: protobuf.partsHeader))
    }
}
