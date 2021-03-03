import NIO

extension RESTRequest {
    static func transaction(id: Int, params: TransactionParameters) -> RESTRequest<TransactionParameters> {
        .init(id: id, method: .transaction, params: params)
    }
}

extension RESTClient {
    func transaction(id: Int, params: TransactionParameters) throws -> EventLoopFuture<RESTResponse<TransactionResponse>> {
        let restRequest = RESTRequest<TransactionParameters>.transaction(id: id, params: params)
        return try self.sendRequest(payload: restRequest)
    }
}

public struct TransactionParameters: Codable {
    let hash: Never
    let prove: Never
}

public struct TransactionResponse: Codable {
    
}
