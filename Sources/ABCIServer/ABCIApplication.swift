// ===----------------------------------------------------------------------===
//
//  This source file is part of the CosmosSwift open source project.
//
//  ABCIApplication.swift last updated 02/06/2020
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
import ABCIMessages

/// ABCI apps should comply to the following protocol.
public protocol ABCIApplication {
    /// Echoes a string to test an abci client/server implementation.
    /// - Parameter request: `Echo` ABCI message request.
    /// - Returns: `Echo` ABCI message response.
    func echo(request: RequestEcho) -> ResponseEcho
    
    /// Signals that messages queued on the client should be flushed to the server.
    ///
    /// `flush` is called periodically to ensure asynchronous requests are actually sent,
    /// and is called immediately to make a synchronous request, which returns when
    /// the `flush` response comes back.
    func flush()

    /// Returns information about the application state.
    ///
    /// Used to sync Tendermint with the application during a handshake that happens on startup.
    /// A stateful application should alway return `lastBlockHash` and `lastBlockHeight` to prevent Tendermint
    /// from replaying from the beginning. If `lastBlockHeight` == 0, Tendermint will call `initChain`.
    ///
    /// NOTICE:
    /// - Called when the app first starts.
    /// - The returned `appVersion` will be included in the `Header` of every block.
    /// - Tendermint expects `lastBlockAppHash` and `lastBlockHeight` to be updated during `Commit`,
    /// ensuring that `Commit` is never called twice for the same block height.
    /// - Parameter request: `Info` ABCI message request.
    /// - Returns: `Info` ABCI message response.
    func info(request: RequestInfo) -> ResponseInfo

    /// Initializes the chain.
    ///
    /// This allows the app to decide if it wants to accept the initial validator set proposed by tendermint
    /// (ie. in the genesis file), or if it wants to use a different one, perhaps computed based on some
    /// application specific information in the genesis file.
    ///
    /// NOTICE:
    /// - Called only once usually at genesis or when the block height is 0.
    /// - If `ResponseInitChain.validators` is empty, the initial validator set will be `RequestInitChain.validators`.
    /// - If `ResponseInitChainQuery.validators` is not empty, it will be the initial validator set regardless of what is in `RequestInitChain.validators`.
    /// - Parameter request: `InitChain` ABCI message request.
    /// - Returns: `InitChain` ABCI message response.
    func initChain(request: RequestInitChain) -> ResponseInitChain

    /// Queries data from the application at current or past height.
    ///
    /// A Merkle proof may be returned with a self-describing `type` property to support many types of Merkle trees and encoding formats.
    /// - Parameter request: `Query` ABCI message request.
    /// - Returns: `Query` ABCI message response.
    func query(request: RequestQuery<Data>) -> ResponseQuery<Data>
    
    /// Signals the beginning of a new block.
    ///
    /// NOTICE:
    /// - Called prior to any `DeliverTx` message.
    /// - The header contains the height, timestamp, and more - it exactly matches the Tendermint block header.
    /// - `RequestBeginBlock.lastCommitInfo` and `RequestBeginBlock.byzantineValidators` can be used to determine rewards and punishments for the validators.
    /// - Validators here do not include public keys.
    /// - Parameter request: `BeginBlock` ABCI message request.
    /// - Returns: `BeginBlock` ABCI message response.
    func beginBlock(request: RequestBeginBlock) -> ResponseBeginBlock
    
    /// Checks transactions before letting the local node insert them in its  mempool.
    ///
    /// Technically optional, since `CheckTx` is not involved in processing blocks.
    /// The transactions may come from an external user or another node.
    /// `CheckTx` need not execute the transaction in full, but rather a light-weight
    /// yet stateful validation, like checking signatures and account balances,
    /// but not running code in a virtual machine.
    /// Transactions where `ResponseCheckTx.code` is not zero will be rejected.
    /// They will not be broadcasted to other nodes or included in a proposal block.
    /// - Parameter request: `CheckTx` ABCI message request.
    /// - Returns: `CheckTx` ABCI message response.
    func checkTx(request: RequestCheckTx) -> ResponseCheckTx

    /// Executes transactions in full.
    ///
    /// Transactions where `ResponseCheckTx.code` is not zero will be rejected.
    /// - Parameter request: `DeliverTx` ABCI message request.
    /// - Returns: `DeliverTx` ABCI message response.
    func deliverTx(request: RequestDeliverTx) -> ResponseDeliverTx

    /// Signals the end of a block.
    ///
    /// Called after all transactions, prior to `Commit`.
    /// Validator updates returned by block `H` impact blocks `H+1`, `H+2` and `H+3`, but only
    /// affects changes on the validator set of `H+2`:
    /// - `H+1`: `nextValidatorHash`.
    /// - `H+2`: `validatorHash` and thus the validator set.
    /// - `H+3`: `lastCommitInfo` ie. the last validator set.
    /// Consensus params returned for block `H` apply for block `H+1`.
    /// - Parameter request: `EndBlock` ABCI message request.
    /// - Returns: `EndBlock` ABCI message response.
    func endBlock(request: RequestEndBlock) -> ResponseEndBlock

    /// Persists the application state.
    ///
    /// Optionally return a Merkle root hash of the applications state.
    /// `ResponseCommit.data` is included as the `Header.appHash` in the next block.
    /// Later calls to `Query` can return proofs about the application state anchored in this Merkle root hash
    ///
    /// NOTICE:
    /// - Developers can return whatever they want here (nothing, a constant string, etc.), so long as it is deterministic
    /// It must be a function of what came from `BeginBlock`, `DeliverTx` and `EndBlock` messages.
    /// Use `ResponseCommit.retainHeight` with caution. If all nodes in the network remove historical blocks then data is permanently lost,
    /// and no new node will be able to join the network and bootstrap. Historical blocks may also be required for other purposes, e.g. auditing,
    /// replay of non-persisted heights, light client verification and so on.
    /// - Parameter request: `Commit` ABCI message request.
    /// - Returns: `Commit` ABCI message response.
    func commit() -> ResponseCommit
    
    /// Used during state sync to discover available snapshots on peers.
    ///
    /// - Returns: `ListSnapshot` ABCI message response.
    func listSnapshots() -> ResponseListSnapshots
    
    /// `OfferSnapshot` is called when bootstrapping a node using state sync.
    /// The application may accept or reject snapshots as appropriate.
    /// Upon accepting, Tendermint will retrieve and apply snapshot chunks via `ApplySnapshotChunk`.
    /// The application may also choose to reject a snapshot in the chunk response,
    /// in which case it should be prepared to accept further `OfferSnapshot` calls.
    ///
    /// Only `appHash` can be trusted, as it has been verified by the light client.
    /// Any other data can be spoofed by adversaries, so applications should employ
    /// additional verification schemes to avoid denial-of-service attacks.
    /// The verified `appHash` is automatically checked against the restored application
    /// at the end of snapshot restoration.
    ///
    /// - Parameter request: `OfferSnapshot` ABCI message request.
    /// - Returns: `OfferSnapshot` ABCI message response.
    func offerSnapshot(request: RequestOfferSnapshot) -> ResponseOfferSnapshot
    
    /// Used during state sync to retrieve snapshot chunks from peers.
    ///
    /// - Parameter request: `LoadSnapshotChunk` ABCI message request.
    /// - Returns: `LoadSnapshotChunk` ABCI message response.
    func loadSnapshotChunk(request: RequestLoadSnapshotChunk) -> ResponseLoadSnapshotChunk
    
    /// The application can choose to refetch chunks and/or ban P2P peers as appropriate.
    /// Tendermint will not do this unless instructed by the application.
    ///
    /// The application may want to verify each chunk, e.g. by attaching chunk hashes in `Snapshot.
    /// metadata` and/or incrementally verifying contents against `appHash`.
    ///
    /// When all chunks have been accepted, Tendermint will make an ABCI `Info` call to verify that
    /// `lastBlockAppHash` and `lastBlockHeight` matches the expected values, and record the `appVersion`
    /// in the node state. It then switches to fast sync or consensus and joins the network.
    ///
    /// If Tendermint is unable to retrieve the next chunk after some time
    /// (e.g. because no suitable peers are available), it will reject the snapshot
    /// and try a different one via `OfferSnapshot`. The application should be prepared
    /// to reset and accept it or abort as appropriate.
    ///
    /// - Parameter request: `ApplySnapshotChunk` ABCI message request
    /// - Returns: `ApplySnapshotChunk` ABCI message response
    func applySnapshotChunk(request: RequestApplySnapshotChunk) -> ResponseApplySnapshotChunk
}

extension ABCIApplication {
    public func echo(request: RequestEcho) -> ResponseEcho {
        .init(message: request.message)
    }
    
    public func flush() {}
}
