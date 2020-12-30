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

public struct Header {
    public let version: Version
    public let chainID: String
    public var height: Int64
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

    public init(
        version: Version = Version(),
        chainID: String,
        height: Int64 = 0,
        time: Date,
        lastBlockID: BlockID = BlockID(),
        lastCommitHash: Data = Data(),
        dataHash: Data = Data(),
        validatorsHash: Data = Data(),
        nextValidatorsHash: Data = Data(),
        consensusHash: Data = Data(),
        appHash: Data = Data(),
        lastResultsHash: Data = Data(),
        evidenceHash: Data = Data(),
        proposerAddress: Data = Data()
    ) {
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
    init(_ header: Tendermint_Types_Header) {
        self.version = Version(header.version)
        self.chainID = header.chainID
        self.height = header.height
        self.time = header.time.date
        self.lastBlockID = BlockID(header.lastBlockID)
        self.lastCommitHash = header.lastCommitHash
        self.dataHash = header.dataHash
        self.validatorsHash = header.validatorsHash
        self.nextValidatorsHash = header.nextValidatorsHash
        self.consensusHash = header.consensusHash
        self.appHash = header.appHash
        self.lastResultsHash = header.lastResultsHash
        self.evidenceHash = header.evidenceHash
        self.proposerAddress = header.proposerAddress
    }
}
