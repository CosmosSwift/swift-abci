// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  EvidenceType.swift last updated 02/06/2020
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

extension EvidenceType {
    init(_ evidenceType: Tendermint_Abci_EvidenceType) {
        switch evidenceType {
        case .duplicateVote:
            self = .duplicateVote
        case .lightClientAttack:
            self = .lightClientAttack
        default:
            self = .unknown
        }
    }
}


extension Tendermint_Abci_EvidenceType {
    init(_ evidenceType: EvidenceType) {
        switch evidenceType {
        case .unknown:
            self = .unknown
        case .duplicateVote:
            self = .duplicateVote
        case .lightClientAttack:
            self = .lightClientAttack
        }
    }
}
