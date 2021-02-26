extension RESTRequest {
    static func broadcastTransactionCommit(id: Int, params: BroadcastTransactionCommitParameters) -> RESTRequest<BroadcastTransactionCommitParameters> {
        .init(id: id, method: .broadcastTransactionCommit, params: params)
    }
}

public struct BroadcastTransactionCommitParameters: RequestParameters {
    public typealias ResponsePayload = BroadcastTransactionCommitResponse
    
    let transaction: Never
}

public struct BroadcastTransactionCommitResponse: Codable {
    
}
