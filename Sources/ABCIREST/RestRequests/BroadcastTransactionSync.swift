import NIO

extension RESTRequest {
    static func broadcastTransactionSync(id: Int, params: BroadcastTransactionSyncParameters) -> RESTRequest<BroadcastTransactionSyncParameters> {
        .init(id: id, method: .broadcastTransactionSync, params: params)
    }
}

extension RESTClient {
    func broadcastTransactionSync(id: Int, params: BroadcastTransactionSyncParameters) throws -> EventLoopFuture<RESTResponse<BroadcastTransactionSyncResponse>> {
        let restRequest = RESTRequest<BroadcastTransactionSyncParameters>.broadcastTransactionSync(id: id, params: params)
        return try self.sendRequest(payload: restRequest)
    }
}

public struct BroadcastTransactionSyncParameters: Codable {
    let transaction: Never
}

public struct BroadcastTransactionSyncResponse: Codable {
    
}
