import NIO

extension RESTRequest {
    static func numUnconfirmedTransactions(id: Int) -> RESTRequest<EmptyParameters> {
        .init(id: id, method: .numUnconfirmedTransactions, params: EmptyParameters())
    }
}

extension RESTClient {
    public func numUnconfirmedTransactions(id: Int) throws -> EventLoopFuture<RESTResponse<NumUnconfirmedTransactionsResponse>> {
        let restRequest = RESTRequest<EmptyParameters>.numUnconfirmedTransactions(id: id)
        return try self.sendRequest(payload: restRequest)
    }
}

public struct NumUnconfirmedTransactionsResponse: Codable {
    
}
