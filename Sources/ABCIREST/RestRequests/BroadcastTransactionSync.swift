extension RESTRequest {
    static func broadcastTransactionSync(id: Int, params: BroadcastTransactionSyncParameters) -> RESTRequest<BroadcastTransactionSyncParameters> {
        .init(id: id, method: .broadcastTransactionSync, params: params)
    }
}

public struct BroadcastTransactionSyncParameters: RequestParameters {
    public typealias ResponsePayload = BroadcastTransactionSyncResponse
    
    let transaction: Never
}

public struct BroadcastTransactionSyncResponse: Codable {
    
}
