import NIO

extension RESTRequest {
    static func broadcastTransactionAsync(id: Int, params: BroadcastTransactionAsyncParameters) -> RESTRequest<BroadcastTransactionAsyncParameters> {
        .init(id: id, method: .broadcastTransactionAsync, params: params)
    }
}

extension RESTClient {
    public func broadcastTransactionAsync(id: Int, params: BroadcastTransactionAsyncParameters) throws -> EventLoopFuture<RESTResponse<BroadcastTransactionAsyncResponse>> {
        let restRequest = RESTRequest<BroadcastTransactionAsyncParameters>.broadcastTransactionAsync(id: id, params: params)
        return try self.sendRequest(payload: restRequest)
    }
}

public struct BroadcastTransactionAsyncParameters: Codable {
    let transaction: Never
}

public struct BroadcastTransactionAsyncResponse: Codable {
    
}
