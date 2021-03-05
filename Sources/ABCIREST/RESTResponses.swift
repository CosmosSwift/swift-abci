//
//  File.swift
//  
//
//  Created by Jaap Wijnen on 05/03/2021.
//

import Foundation

public struct ABCIInfoResponse: Codable { }

public struct ABCIQueryResponse<Payload>: Codable {
    
}

public struct BlockResponse: Codable { }

#warning("this is a blockresponse right?")
public struct BlockByHashResponse: Codable { }

public struct BlockchainResponse: Codable {
    
}

public struct BlockResultsResponse: Codable {
    
}

public struct BroadcastEvidenceResponse: Codable {
    
}

#warning("probably same as syncresponse")
public struct BroadcastTransactionAsyncResponse: Codable {
    
}

public struct BroadcastTransactionCommitResponse: Codable {
    
}

public struct BroadcastTransactionSyncResponse: Codable {
    
}

public struct CheckTransactionResponse: Codable {
    
}

public struct CommitResponse: Codable {
    
}

public struct ConsensusParametersResponse: Codable {
    
}

public struct ConsensusStateResponse: Codable {
    
}

public struct DumpConsensusStateResponse: Codable {
    
}

public struct GenesisResponse: Codable {
    
}

public struct HealthResponse: Codable {

}

public struct NetInfoResponse: Codable {
    
}

public struct NumUnconfirmedTransactionsResponse: Codable {
    
}

public struct StatusResponse: Codable {
    
}

public struct SubscribeResponse: Codable {
    
}

public struct TransactionResponse: Codable {
    
}

public struct TransactionSearchResponse: Codable {
    
}

public struct UnconfirmedTransactionsResponse: Codable {
    
}

public struct UnsubscribeResponse: Codable {
    
}

public struct UnsubscribeAllResponse: Codable {
    
}

public struct ValidatorsResponse: Codable {
    
}
