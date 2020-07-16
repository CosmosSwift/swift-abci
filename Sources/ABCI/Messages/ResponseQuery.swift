// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  ResponseQuery.swift last updated 16/07/2020
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

public class ResponseQuery: ResponseBase {
    public let index: Int64
    public var key: Data
    public let value: Data
    public let proof: Proof
    public let height: Int64
    public let codespace: String

    private init(_ code: UInt32, _ index: Int64, _ key: Data, _ value: Data, _ proof: Proof, _ height: Int64, _ codespace: String, _ log: String) {
        self.index = index
        self.key = key
        self.value = value
        self.proof = proof
        self.height = height
        self.codespace = codespace
        super.init(code, key, log)
    }

    public static func ok(proof: Proof, index: Int64 = 0, key: Data = Data(), value: Data = Data(), height: Int64 = 0, codespace: String = "", log: String = "") -> ResponseQuery {
        return ResponseQuery(0, index, key, value, proof, height, codespace, log)
    }

    public static func error(_ errno: Int, proof: Proof, index: Int64 = 0, key: Data = Data(), value: Data = Data(), height: Int64 = 0, codespace: String = "", log: String = "") -> ResponseQuery {
        assert(errno > 0)
        return ResponseQuery(UInt32(errno), index, key, value, proof, height, codespace, log)
    }
}

extension Tendermint_Abci_Types_ResponseQuery {
    init(_ r: ResponseQuery) {
        code = r.code
        key = r.key
        value = r.value
        proof = Tendermint_Crypto_Merkle_Proof(r.proof)
        index = r.index
        height = r.height
        codespace = r.codespace
        log = r.log
    }
}
