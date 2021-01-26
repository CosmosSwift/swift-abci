//
//  File.swift
//  
//
//  Created by Alex Tran-Qui on 26/01/2021.
//

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

extension PublicKey {
    init(_ publicKey: Tendermint_Abci_Types_PubKey) {
        
        switch publicKey.type.lowercased() {
        case "ed25519":
            self = .ed25519(publicKey.data)
        default:
            self = .none
        }
    }
}

extension Tendermint_Abci_Types_PubKey {
    init(_ publicKey: PublicKey) {
        switch publicKey {
        case .ed25519(let data):
            self.type = "tendermint/PubKeyEd25519"
            self.data = data
        case .secp256K1(let data):
            self.type = "tendermint/PubKeySecp256k1"
            self.data = data
        case .none:
            self.data = Data()
        }
    }
}
