//===----------------------------------------------------------------------===//
//
// This source file is part of the CosmsosSwift/ABCI open source project
//
// Copyright (c) 2019 CosmsosSwift/ABCI project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of CosmsosSwift/ABCI project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//


import ABCI
import ABCINIO
import Foundation
import DataConvertible


/// Simple counter app.  It only excepts values sent to it in order.  The
///  state maintains the current count. For example if starting at state 0, sending:
///  -> 0x01 = ok
///  -> 0x03 = fail (expects 2)
///  To run it:
///  - make a clean new directory for tendermint
///  - start this server: .build/debug/ABCICounter
///  - start tendermint: tendermint --home "YOUR DIR HERE" node
///  - The send transactions to the app:
///  curl http://localhost:26657/broadcast_tx_commit?tx=0x01
///  curl http://localhost:26657/broadcast_tx_commit?tx=0x02
///  ...
///  to see the latest count:
///  curl http://localhost:26657/abci_query
///  The way the app state is structured, you can also see the current state value
///  in the tendermint console output.
class CounterApp: ABCIApplication {

    var txCount: UInt64 = 0
    var lastBlockheight: UInt64 = 0
    var serial: Bool = false
    
    func validate(_ tx: Data) -> Bool {
        var  padded = Data(count: 8 - tx.count)
        padded.append(tx)
        let value = UInt64(data: padded)?.bigEndian ?? 0// the encoding is bigEndian, so have to reverse it
        return value == txCount + 1
    }
    
    public func echo(_ message: String) -> ResponseEcho {
        return ResponseEcho(message: message)
    }
    
    func initChain(_ time: Date, _ chainId: String, _ consensusParams: ConsensusParams, _ updates: [ValidatorUpdate], _ appStateBytes: Data) -> ResponseInitChain {
        // Sets initial state on first run
        txCount = 0
        let bp = BlockParams(maxBytes: 4096, maxGas: 1000)
        let ep = EvidenceParams(maxAge: 10000)
        let vp = ValidatorParams(pubKeyTypes: ["ed25519"])
        let cu = ConsensusParams(bp, ep, vp)
        return ResponseInitChain(cu, [])
    }
    
    func info(_ version: String, _ blockVersion: UInt64, _ p2pVersion: UInt64) -> ResponseInfo {
        return ResponseInfo("{\"hashes\":\(lastBlockheight),\"txs\":\(txCount)}", version, 0, 0, Data())
    }
    
    func deliverTx(_ tx: Data) -> ResponseDeliverTx {
        // Mutate state if valid Tx
        if serial && !validate(tx) { return ResponseDeliverTx.error(3, log:"bad count") }

        self.txCount += 1
        return ResponseDeliverTx.ok()
    }
    
    func checkTx(_ tx: Data) -> ResponseCheckTx {
        // Validate the Tx before entry into the mempool
        if serial && !validate(tx) { return ResponseCheckTx.error(3, log:"bad count") }
        
        return ResponseCheckTx.ok(log: "All good")
    }
    
    func query(_ q: Query) -> ResponseQuery {
        // Returns the last Tx count
        let k = "count".data
        let v = txCount.bigEndian.data
        let p = Proof(ops: [])
        return ResponseQuery.ok(proof: p, key: k, value: v, height: q.height, log: "query")
    }
    
    func commit() -> ResponseCommit {
        // Return the current encode state value to tendermint
        let h = txCount.bigEndian.data
        return ResponseCommit.ok(data:h)
    }
    
    func beginBlock(_ hash: Data, _ header: Header, _ lastCommitInfo: LastCommitInfo, _ byzantineValidators: [Evidence]) -> ResponseBeginBlock {
        lastBlockheight += 1
        return ResponseBeginBlock([])
    }
    
    func setOption(_ key: String, _ value: String) -> ResponseSetOption {
        if key == "serial" {
            serial = value == "on"
        }
        return ResponseSetOption("key: \(key) value: \(value)")
    }
    
    public func endBlock(_ height: Int64) -> ResponseEndBlock {
        // Called at the end of processing. If this is a stateful application
        // you can use the height from here to record the last_block_height
        // Consensus parameters update
        let bp = BlockParams(maxBytes: 22020096, maxGas: -1)
        let ep = EvidenceParams(maxAge: 100000)
        let vp = ValidatorParams(pubKeyTypes: ["ed25519"])
        let cu = ConsensusParams(bp, ep, vp)
        let e: [Event] = []
        return ResponseEndBlock(updates: [], consensusUpdates: cu, events: e)
    }
}



let server = NIOABCIServer(CounterApp())

try server.start()
