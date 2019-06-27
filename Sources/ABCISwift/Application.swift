//
//  Application.swift
//  ABCISwift
//

import Foundation

// ABCI apps should comply to the following protocol
public protocol ABCIApplication {
    
    func initChain(_ validators: [Validator])
    func info(_ version: String) -> ResponseInfo
    func echo(_ message: String) -> ResponseEcho
    func flush()
    func setOption(_ key: String, _ value: String) -> ResponseSetOption
    func deliverTx(_ tx: Data) -> Result
    func checkTx(_ tx: Data) -> Result
    func query(_ q: Query) -> ResponseQuery
    func beginBlock(_ hash: Data, _ header: Header, _ absentValidators: Int32, _ byzantineValidators: Evidence)
    func endBlock(_ height: Int64) -> ResponseEndBlock
    func commit() -> Result
}

extension ABCIApplication {
    public func initChain(_ validators: [Validator]) {
        // Called only once when blockheight == 0
    }
    
    public func info(_ version: String) -> ResponseInfo {
        // Called by ABCI when the app first starts. A stateful application
        // should alway return the last blockhash and blockheight to prevent Tendermint
        // replaying from the beginning. If blockheight == 0, Tendermint will call init_chain

        return ResponseInfo(data: "info", version: version, lastBlockHeight: 0, lastBlockAppHash: Data())
    }
    
    public func echo(_ message: String) -> ResponseEcho {
        return ResponseEcho(message: message)
    }
    
    public func flush() {}
    
    public func setOption(_ key: String, _ value: String) -> ResponseSetOption {
        // Can be used to set key value pairs in storage. Not always used
        return ResponseSetOption("key: \(key) value: \(value)")
    }
    
    public func deliverTx(_ tx: Data) -> Result {
        // Called to calculate state on a given block during the consensus process
        return ResponseDeliverTx.ok(log: "delivertx")
    }
    
    public func checkTx(_ tx: Data) -> Result {
        // Use to validate incoming transactions.  If Result.ok is returned,
        // the Tx will be added to Tendermint's mempool
        return ResponseCheckTx.ok(log: "checktx")
    }
    
    public func query(_ q: Query) -> ResponseQuery {
        // Called over RPC to query the application state
        return ResponseQuery.ok(key: q.data, value: q.data, proof: q.data, height: q.height, log: "query")

    }
    
    public func beginBlock(_ hash: Data, _ header: Header, _ absentValidators: [Int32], _ byzantineValidators: [Evidence]) {
        // Called to process a block
    }
    
    public func endBlock(_ height: Int64) -> ResponseEndBlock {
        // Called at the end of processing. If this is a stateful application
        // you can use the height from here to record the last_block_height
        // Consensus parameters update
        let bs = BlockSize(maxBytes: 0,maxTxs: 0,maxGas: 0)
        let ts = TxSize(maxBytes: 0,maxGas: 0)
        let bg = BlockGossip(blockPartSizeBytes: 1)
        let cu = ConsensusParams(blockSize: bs, txSize: ts, blockGossip: bg)
        return ResponseEndBlock(updates: [], consensusUpdates: cu)
    }
    
    public func commit() -> Result {
        // Called to get the result of processing transactions.  If this is a
        // stateful application using a Merkle Tree, this method should return
        // the root hash of the Merkle Tree in the Result data field
        return ResponseCommit.ok()
    }
}
