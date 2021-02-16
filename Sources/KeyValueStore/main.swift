// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  main.swift last updated 02/06/2020
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

import ABCIServer
import ABCIMessages
import ABCINIO
import Foundation

public final class Store {
    public final class Transaction {
        var storage: [String: String] = [:]
        
        init() {}
         
        public func put(key: String, value: String) {
            self.storage[key] = value
        }
    }
    
    private var storage: [String: String] = [:]
    
    public init() {}
    
    public func makeTransaction() -> Transaction {
        Transaction()
    }
    
    public func get(key: String) -> String? {
        self.storage[key]
    }
     
    public func commit(transaction: Transaction) {
        self.storage.merge(transaction.storage, uniquingKeysWith: { _, new in new })
    }
}

public final class KeyValueStoreApp {
    private let store = Store()
    private var transaction: Store.Transaction? = nil
     
    public init() {}
}

extension KeyValueStoreApp: ABCIApplication {
    public func echo(request: RequestEcho) -> ResponseEcho {
        .init(message: request.message)
    }

    public func info(request: RequestInfo) -> ResponseInfo {
        .init()
    }

    public func initChain(request: RequestInitChain) -> ResponseInitChain {
        .init()
    }

    public func query(request: RequestQuery<Data>) -> ResponseQuery<Data> {
        guard let key = String(data: request.data, encoding: .utf8) else {
            return ResponseQuery(code: 1)
        }
        
        guard let value = self.persistedValue(key: key) else {
            return ResponseQuery(log: "does not exist")
        }
        
        return .init(
            log: "exists",
            key: key.data(using: .utf8)!,
            value: value.data(using: .utf8)!
        )
    }

    public func beginBlock(request: RequestBeginBlock) -> ResponseBeginBlock {
        self.transaction = self.store.makeTransaction()
        return .init()
    }

    public func checkTx(request: RequestCheckTx) -> ResponseCheckTx {
        let result = self.validate(tx: request.tx)
        return .init(code: result.code, gasWanted: 1)
    }

    public func deliverTx(request: RequestDeliverTx) -> ResponseDeliverTx {
        let result = self.validate(tx: request.tx)
        
        if case .valid(let key, let value) = result {
            self.persist(key: key, value: value)
        }
        
        return .init(code: result.code)
    }
    
    public func endBlock(request: RequestEndBlock) -> ResponseEndBlock {
        .init()
    }

    public func commit() -> ResponseCommit {
        guard let transaction = self.transaction else {
            fatalError("Unexpected state. Transaction should exist during commit.")
        }
        
        self.store.commit(transaction: transaction)
        return .init(data: Data(count: 8))
    }
    
    public func listSnapshots() -> ResponseListSnapshots {
        .init()
    }
    
    public func offerSnapshot(request: RequestOfferSnapshot) -> ResponseOfferSnapshot {
        .init()
    }
    
    public func loadSnapshotChunk(request: RequestLoadSnapshotChunk) -> ResponseLoadSnapshotChunk {
        .init()
    }
    
    public func applySnapshotChunk(request: RequestApplySnapshotChunk) -> ResponseApplySnapshotChunk {
        .init()
    }
}

enum ValidationResult {
    case invalidStringEncoding
    case invalidFormat
    case valueAlreadyExists
    case valid(key: String, value: String)
    
    var code: UInt32 {
        switch self {
        case .invalidStringEncoding:
            return 1
        case .invalidFormat:
            return 2
        case .valueAlreadyExists:
            return 3
        case .valid:
            return 0
        }
    }
}

extension KeyValueStoreApp {
    private func validate(tx: Data) -> ValidationResult {
        guard let string = String(data: tx, encoding: .utf8) else {
            return .invalidStringEncoding
        }
        
        let parts = string.split(separator: "=")
        
        guard parts.count == 2 else {
            return .invalidFormat
        }
        
        let key = String(parts[0])
        let value = String(parts[1])

        if let stored = self.persistedValue(key: key), stored == value {
            return .valueAlreadyExists
        }
        
        return .valid(key: key, value: value)
    }

    func persistedValue(key: String) -> String? {
        self.store.get(key: key)
    }
    
    func persist(key: String, value: String) {
        self.transaction?.put(key: key, value: value)
    }
}

let app = KeyValueStoreApp()
let server = NIOABCIServer(application: app)
try server.start()
