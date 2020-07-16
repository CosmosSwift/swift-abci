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

import Foundation

public class Header {
    public let version: Version
    public let chainID: String
    public let height: Int64
    public let time: Date
    public let lastBlockID: BlockID
    public let lastCommitHash: Data
    public let dataHash: Data
    public let validatorsHash: Data
    public let nextValidatorsHash: Data
    public let consensusHash: Data
    public let appHash: Data
    public let lastResultsHash: Data
    public let evidenceHash: Data
    public let proposerAddress: Data

    init(_ version: Version, _ chainID: String, _ height: Int64, _ time: Date, _ lastBlockID: BlockID, _ lastCommitHash: Data, _ dataHash: Data,
         _ validatorsHash: Data, _ nextValidatorsHash: Data, _ consensusHash: Data, _ appHash: Data,
         _ lastResultsHash: Data, _ evidenceHash: Data, _ proposerAddress: Data) {
        self.version = version
        self.chainID = chainID
        self.height = height
        self.time = time
        self.lastBlockID = lastBlockID

        self.lastCommitHash = lastCommitHash
        self.dataHash = dataHash
        self.validatorsHash = validatorsHash
        self.nextValidatorsHash = nextValidatorsHash
        self.consensusHash = consensusHash
        self.appHash = appHash
        self.lastResultsHash = lastResultsHash
        self.evidenceHash = evidenceHash
        self.proposerAddress = proposerAddress
    }
}

extension Header {
    convenience init(protobuf: Tendermint_Abci_Types_Header) {
        self.init(Version(protobuf.version.block, protobuf.version.app),
                  protobuf.chainID,
                  protobuf.height,
                  protobuf.time.date,
                  BlockID(protobuf: protobuf.lastBlockID),
                  protobuf.lastCommitHash,
                  protobuf.dataHash,
                  protobuf.validatorsHash,
                  protobuf.nextValidatorsHash,
                  protobuf.consensusHash,
                  protobuf.appHash,
                  protobuf.lastResultsHash,
                  protobuf.evidenceHash,
                  protobuf.proposerAddress)
    }
}
