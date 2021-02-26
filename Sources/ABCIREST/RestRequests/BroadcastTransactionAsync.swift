extension RESTRequest {
    static func broadcastTransactionAsync(id: Int, params: BroadcastTransactionAsyncParameters) -> RESTRequest<BroadcastTransactionAsyncParameters> {
        .init(id: id, method: .broadcastTransactionAsync, params: params)
    }
}

public struct BroadcastTransactionAsyncParameters: RequestParameters {
    public typealias ResponsePayload = BroadcastTransactionAsyncResponse
    
    let transaction: Never
}

public struct BroadcastTransactionAsyncResponse: Codable {
    
}
