//
//  File.swift
//  
//
//  Created by Jaap Wijnen on 05/03/2021.
//

import Foundation

public struct ABCIQueryParameters<Payload>: Codable {
    
}

public struct BlockParameters: Codable {
    let height: Never
}

public struct BlockByHashParameters: Codable {
    let hash: Never
}

public struct BlockchainParameters: Codable {
    let minHeight: Never
    let maxHeight: Never
}

public struct BlockResultsParameters: Codable {
    let height: Never
}

public struct BroadcastEvidenceParameters: Codable {
    let evidence: Never
}

#warning("maybe same as sync response?")
public struct BroadcastTransactionAsyncParameters: Codable {
    let transaction: Never
}

public struct BroadcastTransactionCommitParameters: Codable {
    let transaction: Never
}

public struct BroadcastTransactionSyncParameters: Codable {
    let transaction: Never
}

public struct CheckTransactionParameters: Codable {
    let transaction: Never
}

public struct CommitParameters: Codable {
    let height: Never
}

public struct ConsensusParametersParameters: Codable {
    let height: Never
}

public struct SubscribeParameters: Codable {
    let query: Never
}

public struct TransactionParameters: Codable {
    let hash: Never
    let prove: Never
}

public struct TransactionSearchParameters: Codable {
    let query: Never
    let prove: Never
    let page: Never
    let perPage: Never
    let orderBy: Never
}

public struct UnconfirmedTransactionsParameters: Codable {
    let limit: Never
}

public struct UnsubscribeParameters: Codable {
    let query: Never
}

public struct ValidatorsParameters: Codable {
    let page: Never
    let perPage: Never
}
