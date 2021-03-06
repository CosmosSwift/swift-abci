// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  ResponseInfo.swift last updated 16/07/2020
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

extension RequestInfo {
    init(_ tendermintRequest: Tendermint_Abci_RequestInfo) {
        self.init(version: tendermintRequest.version,
                  blockVersion: tendermintRequest.blockVersion,
                  p2pVersion: tendermintRequest.p2PVersion)
    }
}
