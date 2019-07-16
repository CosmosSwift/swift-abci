//
//  Application.swift
//  ABCISwift
//

import Foundation

// ABCI apps should comply to the following protocol
public protocol ABCIApplication {
    
    // Called only once usually at genesis or when blockheight == 0
    // see info()
    func initChain(_ time: Date, _ chainId: String, _ consensusParams: ConsensusParams, _ updates: [ValidatorUpdate], _ appStateBytes: Data) -> ResponseInitChain

    // Called by ABCI when the app first starts. A stateful application
    // should alway return the last blockhash and blockheight to prevent Tendermint
    // replaying from the beginning. If blockheight == 0, Tendermint will call init_chain
    func info(_ version: String, _ blockVersion: UInt64, _ p2pVersion: UInt64) -> ResponseInfo

    func echo(_ message: String) -> ResponseEcho
    
    func flush()
    
    // Can be used to set key value pairs in storage. Not always used
    func setOption(_ key: String, _ value: String) -> ResponseSetOption
    
    // Process the tx and apply state changes.
    // This is called via the consensus connection.
    // A non-zero response code implies an error and will reject the tx
    func deliverTx(_ tx: Data) -> ResponseDeliverTx

    // Use to validate incoming transactions.  If Result.ok is returned,
    // the Tx will be added to Tendermint's mempool for consideration in a block.
    // A non-zero response code implies an error and will reject the tx
    func checkTx(_ tx: Data) -> ResponseCheckTx
    
    // This is commonly used to query the state of the application.
    // A non-zero 'code' in the response is used to indicate and error.
    func query(_ q: Query) -> ResponseQuery
    
    // Called during the consensus process.  The overall flow is:
    // begin_block()
    // for each tx:
    //    deliver_tx(tx)
    //    end_block()
    // commit()
    func beginBlock(_ hash: Data, _ header: Header, _ lastCommitInfo: LastCommitInfo, _ byzantineValidators: [Evidence]) -> ResponseBeginBlock
    
    // Called at the end of processing. If this is a stateful application
    // you can use the height from here to record the last_block_height
    // Consensus parameters update
    func endBlock(_ height: Int64) -> ResponseEndBlock
    
    // Called to get the result of processing transactions.  If this is a
    // stateful application using a Merkle Tree, this method should return
    // the root hash of the Merkle Tree in the Result data field
    func commit() -> ResponseCommit
}

extension ABCIApplication {
    public func flush() {}
}
