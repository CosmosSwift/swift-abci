//
//  File.swift
//  
//
//  Created by Alex Tran-Qui on 26/01/2021.
//

import Foundation

/// Used during state sync to retrieve snapshot chunks from peers.
public struct RequestLoadSnapshotChunk {
    /// The height of the snapshot the chunks belongs to.
    public let height: UInt64
    
    /// The application-specific format of the snapshot the chunk belongs to.
    public let format: UInt32
    
    /// The chunk index, starting from 0 for the initial chunk.
    public let chunk: UInt32
}

//extension RequestLoadSnapshotChunk {
//    init(_ request: Tendermint_Abci_RequestLoadSnapshotChunk) {
//        self.height = request.height
//        self.format = request.format
//        self.chunk = request.chunk
//    }
//}

/// Used during state sync to retrieve snapshot chunks from peers.
public struct ResponseLoadSnapshotChunk {
    /// The binary chunk contents, in an arbitray format.
    /// Chunk messages cannot be larger than 16 MB including metadata, so 10 MB is a good starting point.
    public let chunk: Data
    
    /// Used during state sync to retrieve snapshot chunks from peers.
    ///
    /// - Parameter chunk: The binary chunk contents, in an arbitray format. Chunk messages cannot be larger than 16 MB including metadata, so 10 MB is a good starting point.
    public init(chunk: Data = Data()) {
        self.chunk = chunk
    }
}

//extension Tendermint_Abci_ResponseLoadSnapshotChunk {
//    init(_ response: ResponseLoadSnapshotChunk) {
//        self.chunk = response.chunk
//    }
//}

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
public struct RequestApplySnapshotChunk {
    /// The chunk index, starting from 0. Tendermint applies chunks sequentially.
    public let index: UInt32
    
    /// The binary chunk contents, as returned by `loadSnapshotChunk`.
    public let chunk: Data
    
    /// The P2P ID of the node who sent this chunk.
    public let sender: String
}

//extension RequestApplySnapshotChunk {
//    init(_ request: Tendermint_Abci_RequestApplySnapshotChunk) {
//        self.index = request.index
//        self.chunk = request.chunk
//        self.sender = request.sender
//    }
//}


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
public struct ResponseApplySnapshotChunk {
    public enum Result {
      /// Unknown result, abort all snapshot restoration.
      case unknown
      /// The chunk was accepted.
      case accept
      /// Abort snapshot restoration, and don't try any other snapshots.
      case abort
      /// Reapply this chunk, combine with `refetchChunks` and `rejectSenders` as appropriate.
      case retry
      /// Restart this snapshot from `OfferSnapshot`, reusing chunks unless instructed otherwise.
      case retrySnapshot
      /// Reject this snapshot, try a different one.
      case rejectSnapshot
    }
    
    /// The result of applying this chunk.
    public let result: Result
    
    /// Refetch and reapply the given chunks, regardless of Result.
    /// Only the listed chunks will be refetched, and reapplied in sequential order.
    public let refetchChunks: [UInt32]
    
    /// Reject the given P2P senders, regardless of Result.
    /// Any chunks already applied will not be refetched unless explicitly requested,
    /// but queued chunks from these senders will be discarded, and new chunks or other snapshots rejected.
    public let rejectSenders: [String]
    
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
    /// - Parameters:
    ///   - result: The result of applying this chunk.
    ///   - refetchChunks: Refetch and reapply the given chunks, regardless of Result. Only the listed chunks will be refetched, and reapplied in sequential order=.
    ///   - rejectSenders: Reject the given P2P senders, regardless of Result. Any chunks already applied will not be refetched unless explicitly requested, but queued chunks from these senders will be discarded, and new chunks or other snapshots rejected.
    public init(
        result: Result = .unknown,
        refetchChunks: [UInt32] = [],
        rejectSenders: [String] = []
    ) {
        self.result = result
        self.refetchChunks = refetchChunks
        self.rejectSenders = rejectSenders
    }
}

//extension Tendermint_Abci_ResponseApplySnapshotChunk {
//    init(_ response: ResponseApplySnapshotChunk) {
//        switch response.result {
//        case .unknown:
//            self.result = .unknown
//        case .accept:
//            self.result = .accept
//        case .abort:
//            self.result = .abort
//        case .retry:
//            self.result = .retry
//        case .retrySnapshot:
//            self.result = .retrySnapshot
//        case .rejectSnapshot:
//            self.result = .rejectSnapshot
//        }
//
//        self.refetchChunks = response.refetchChunks
//        self.rejectSenders = response.rejectSenders
//    }
//}


/// Used during state sync to discover available snapshots on peers.
public struct ResponseListSnapshots {
    /// List of local state snapshots.
    public let snapshots: [Snapshot]
    
    /// Used during state sync to discover available snapshots on peers.
    /// - Parameter snapshots: List of local state snapshots.
    public init(snapshots: [Snapshot] = []) {
        self.snapshots = snapshots
    }
}

//extension Tendermint_Abci_ResponseListSnapshots {
//    init(_ response: ResponseListSnapshots) {
//        self.snapshots = response.snapshots.map(Tendermint_Abci_Snapshot.init)
//    }
//}

public struct RequestOfferSnapshot {
    /// The snapshot offered for restoration.
    public let snapshot: Snapshot
    
    /// The light client-verified app hash for this height, from the blockchain.
    public let appHash: Data
}

//extension RequestOfferSnapshot {
//    init(_ request: Tendermint_Abci_RequestOfferSnapshot) {
//        self.snapshot = Snapshot(request.snapshot)
//        self.appHash = request.appHash
//    }
//}


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
public struct ResponseOfferSnapshot {
    public enum Result {
      /// Unknown result, abort all snapshot restoration.
      case unknown
      /// Snapshot accepted, apply chunks.
      case accept
      /// Abort all snapshot restoration.
      case abort
      /// Reject this specific snapshot, try others.
      case reject
      /// Reject all snapshots of this `format`, try others.
      case rejectFormat
      /// Reject all snapshots from the sender(s), try others.
      case rejectSender
    }
    
    /// The result of the snapshot offer.
    public let result: Result
    
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
    /// - Parameter result: The result of the snapshot offer.
    public init(result: Result = .unknown) {
        self.result = result
    }
}

//extension Tendermint_Abci_ResponseOfferSnapshot {
//    init(_ response: ResponseOfferSnapshot) {
//        switch response.result {
//        case .unknown:
//            self.result = .unknown
//        case .accept:
//            self.result = .accept
//        case .abort:
//            self.result = .abort
//        case .reject:
//            self.result = .reject
//        case .rejectFormat:
//            self.result = .rejectFormat
//        case .rejectSender:
//            self.result = .rejectSender
//        }
//    }
//}

/// Used for state sync snapshots.
///
/// A snapshot is considered identical across nodes only if all fields are equal (including `metadata`).
/// Chunks may be retrieved from all nodes that have the same snapshot.
///
/// When sent across the network, a snapshot message can be at most 4 MB.
public struct Snapshot {
    /// The height at which the snapshot was taken (after commit).
    let height: UInt64

    /// The application-specific snapshot format, allowing applications to version their snapshot data format and make backwards-incompatible changes. Tendermint does not interpret this.
    let format: UInt32

    /// The number of chunks in the snapshot. Must be at least 1 (even if empty).
    let chunks: UInt32
    
    /// An arbitrary snapshot hash. Must be equal only for identical snapshots across nodes. Tendermint does not interpret the hash, it only compares them.
    let hash: Data
    
    /// Arbitrary application metadata, for example chunk hashes or other verification data.
    let metadata: Data
    
    /// Used for state sync snapshots.
    ///
    /// A snapshot is considered identical across nodes only if all fields are equal (including `metadata`).
    /// Chunks may be retrieved from all nodes that have the same snapshot.
    ///
    /// When sent across the network, a snapshot message can be at most 4 MB.
    ///
    /// - Parameters:
    ///   - height: The height at which the snapshot was taken (after commit).
    ///   - format: The application-specific snapshot format, allowing applications to version their snapshot data format and make backwards-incompatible changes. Tendermint does not interpret this.
    ///   - chunks: The number of chunks in the snapshot. Must be at least 1 (even if empty).
    ///   - hash: An arbitrary snapshot hash. Must be equal only for identical snapshots across nodes. Tendermint does not interpret the hash, it only compares them.
    ///   - metadata: Arbitrary application metadata, for example chunk hashes or other verification data.
    public init(
        height: UInt64 = 0,
        format: UInt32 = 0,
        chunks: UInt32 = 0,
        hash: Data = Data(),
        metadata: Data = Data()
    ) {
        self.height = height
        self.format = format
        self.chunks = chunks
        self.hash = hash
        self.metadata = metadata
    }
}

//extension Snapshot {
//    init(_ snapshot: Tendermint_Abci_Snapshot) {
//        self.height = snapshot.height
//        self.format = snapshot.format
//        self.chunks = snapshot.chunks
//        self.hash = snapshot.hash
//        self.metadata = snapshot.metadata
//    }
//}

//extension Tendermint_Abci_Snapshot {
//    init(_ snapshot: Snapshot) {
//        self.height = snapshot.height
//        self.format = snapshot.format
//        self.chunks = snapshot.chunks
//        self.hash = snapshot.hash
//        self.metadata = snapshot.metadata
//    }

