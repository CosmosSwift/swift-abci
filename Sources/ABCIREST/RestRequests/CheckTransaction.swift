import NIO

extension RESTRequest {
    static func checkTransaction(id: Int, params: CheckTransactionParameters) -> RESTRequest<CheckTransactionParameters> {
        .init(id: id, method: .checkTransaction, params: params)
    }
}

extension RESTClient {
    func checkTransaction(id: Int, params: CheckTransactionParameters) throws -> EventLoopFuture<RESTResponse<CheckTransactionResponse>> {
        let restRequest = RESTRequest<CheckTransactionParameters>.checkTransaction(id: id, params: params)
        return try self.sendRequest(payload: restRequest)
    }
}

public struct CheckTransactionParameters: Codable {
    let transaction: Never
}

public struct CheckTransactionResponse: Codable {
    
}
