import ABCIMessages

public enum RESTRequestError: Swift.Error {
    case badPayload
    case badStringForUInt
    case wrongJSONRPCVersion
    case badRequest
    case badResponse
    case unknown
}

enum RESTRequestMethod: String, Codable {
    case abciInfo = "abci_info"
    case abciQuery = "abci_query"
    case block
    case blockByHash = "block_by_hash"
    case blockResults = "block_results"
    case blockchain
    case broadcastEvidence = "broadcast_evidence"
    case broadcastTransactionAsync = "broadcast_tx_async"
    case broadcastTransactionCommit = "broadcast_tx_commit"
    case broadcastTransactionSync = "broadcast_tx_sync"
    case checkTransaction = "check_tx"
    case commit
    case consensusParameters = "consensus_params"
    case consensusState = "consensus_state"
    case dumpConsensusState = "dump_consensus_state"
    case genesis
    case health
    case netInfo = "net_info"
    case numUnconfirmedTransactions = "num_unconfirmed_txs"
    case status
    case subscribe
    case transaction = "tx"
    case transactionSearch = "tx_search"
    case unconfirmedTransactions = "unconfirmed_txs"
    case unsubscribe
    case unsubscribeAll = "unsubscribe_all"
    case validators
}

public struct RESTRequest<Parameters: Codable> {
    let id: Int
    let method: RESTRequestMethod
    let params: Parameters
}

extension RESTRequest: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case jsonRPC = "jsonrpc"
        case method
        case params
    }
    
    #warning("If we decode a request there is no typesafety on the combination of method and params")
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        guard let jsonRPC = try? container.decode(String.self, forKey: .jsonRPC), jsonRPC == ABCI_REST.jsonRpcVersion else {
            throw RESTRequestError.wrongJSONRPCVersion
        }
        self.id = try container.decode(Int.self, forKey: .id)
        self.method = try container.decode(RESTRequestMethod.self, forKey: .method)
        self.params = try container.decode(Parameters.self, forKey: .params)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(ABCI_REST.jsonRpcVersion, forKey: .jsonRPC)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.method, forKey: .method)
        try container.encode(self.params, forKey: .params)
    }
}
