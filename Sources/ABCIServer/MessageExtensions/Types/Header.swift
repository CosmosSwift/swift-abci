// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  Header.swift last updated 02/06/2020
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

extension Header {
    init(_ header: Tendermint_Types_Header) {
        self.init(version: Version(header.version),
                  chainID: header.chainID,
                  height: header.height,
                  time: header.time.date,
                  lastBlockID: BlockID(header.lastBlockID),
                  lastCommitHash: header.lastCommitHash,
                  dataHash: header.dataHash,
                  validatorsHash: header.validatorsHash,
                  nextValidatorsHash: header.nextValidatorsHash,
                  consensusHash: header.consensusHash,
                  appHash: header.appHash,
                  lastResultsHash: header.lastResultsHash,
                  evidenceHash: header.evidenceHash,
                  proposerAddress: header.proposerAddress)
    }
}
