import NIO

extension RESTRequest {
    static func unconfirmedTransactions(id: Int, params: UnconfirmedTransactionsParameters) -> RESTRequest<UnconfirmedTransactionsParameters> {
        .init(id: id, method: .unconfirmedTransactions, params: params)
    }
}

extension RESTClient {
    public func unconfirmedTransactions(id: Int, params: UnconfirmedTransactionsParameters) throws -> EventLoopFuture<RESTResponse<UnconfirmedTransactionsResponse>> {
        let restRequest = RESTRequest<UnconfirmedTransactionsParameters>.unconfirmedTransactions(id: id, params: params)
        return try self.sendRequest(payload: restRequest)
    }
}

public struct UnconfirmedTransactionsParameters: Codable {
    let limit: Never
}

public struct UnconfirmedTransactionsResponse: Codable {
    
}
