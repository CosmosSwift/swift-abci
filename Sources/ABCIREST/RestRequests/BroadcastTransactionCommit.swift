import NIO

extension RESTRequest {
    static func broadcastTransactionCommit(id: Int, params: BroadcastTransactionCommitParameters) -> RESTRequest<BroadcastTransactionCommitParameters> {
        .init(id: id, method: .broadcastTransactionCommit, params: params)
    }
}

extension RESTClient {
    public func broadcastTransactionCommit(id: Int, params: BroadcastTransactionCommitParameters) throws -> EventLoopFuture<RESTResponse<BroadcastTransactionCommitResponse>> {
        let restRequest = RESTRequest<BroadcastTransactionCommitParameters>.broadcastTransactionCommit(id: id, params: params)
        return try self.sendRequest(payload: restRequest)
    }
}

public struct BroadcastTransactionCommitParameters: Codable {    
    let transaction: Never
}

public struct BroadcastTransactionCommitResponse: Codable {
    
}
