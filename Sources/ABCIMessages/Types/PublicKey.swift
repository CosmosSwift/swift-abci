// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  PublicKey.swift last updated 02/06/2020
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

public enum PublicKey {
    case ed25519(Data)
    case secp256K1(Data)
    case none
    
    var data: Data? {
        switch self {
        case .ed25519(let data):
            return data
        case .secp256K1(let data):
            return data
        default:
            return nil
        }
    }
}

extension PublicKey: Equatable {
    public static func == (lhs: PublicKey, rhs: PublicKey) -> Bool {
        switch (lhs, rhs) {
        case (.ed25519(let lhsData), .ed25519(let rhsData)):
            return lhsData == rhsData
        case (.secp256K1(let lhsData), .secp256K1(let rhsData)):
            return lhsData == rhsData
        default:
            // TODO: Check if this should really be true
            return true
        }
    }
}
