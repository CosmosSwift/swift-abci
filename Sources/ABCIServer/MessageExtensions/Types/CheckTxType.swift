// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  Query.swift last updated 02/06/2020
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

extension CheckTxType {
    init(_ type: Tendermint_Abci_CheckTxType) {
        switch type {
        case .new:
            self = .new
        case .recheck:
            self = .recheck
        case .UNRECOGNIZED(let code):
            self = .unrecognized(code)
        }
    }
}
